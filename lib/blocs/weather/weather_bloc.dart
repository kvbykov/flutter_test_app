import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_case/models/weather_models/city.dart';
import 'package:test_case/models/weather_models/models.dart';
import 'package:test_case/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repo;
  Timer? _timer;

  WeatherBloc(WeatherRepository? repo)
      : _repo = repo ?? WeatherRepository(),
        super(const WeatherState()) {
    on<WeatherSearchSubmitted>(_onSearchSubmitted);
    on<_WeatherAutoUpdated>(_onAutoUpdated);
  }

  Future<void> _onSearchSubmitted(
    WeatherSearchSubmitted event,
    Emitter<WeatherState> emit,
  ) async {
    if (event.city.isEmpty) return;
    emit(state.copyWith(
      city: City.dirty(event.city),
      status: WeatherStatus.inProgress,
    ));
    final Weather weather;
    try {
      weather = await _repo.getWeather(event.city);
    } catch (e) {
      return emit(state.copyWith(status: WeatherStatus.failure));
    }
    emit(state.copyWith(
      status: WeatherStatus.success,
      weather: weather,
    ));
    _setUpdateTimer();
  }

  Future<void> _loadWeather(Emitter<WeatherState> emit) async {
    final Weather weather;
    emit(state.copyWith(
      status: WeatherStatus.inProgress,
    ));
    try {
      weather = await _repo.getWeather(state.city.value);
    } catch (e) {
      return emit(state.copyWith(
        status: WeatherStatus.failure,
      ));
    }
    emit(state.copyWith(
      status: WeatherStatus.success,
      weather: weather,
    ));
  }

  /// Cancels the old timer if it exists, sets a new one to fetch weather data every 60 seconds
  void _setUpdateTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
        const Duration(seconds: 60), (_) => add(_WeatherAutoUpdated()));
  }

  Future<void> _onAutoUpdated(
    _WeatherAutoUpdated _,
    Emitter<WeatherState> emit,
  ) async {
    await _loadWeather(emit);
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    super.close();
  }
}
