part of 'weather_bloc.dart';

enum WeatherStatus { initial, inProgress, success, failure }

final class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final City city;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather = Weather.empty,
    this.city = const City.pure(),
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    City? city,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      city: city ?? this.city,
    );
  }

  bool get isInitial => status == WeatherStatus.initial;
  bool get isFailure => status == WeatherStatus.failure;
  bool get isInProgress => status == WeatherStatus.inProgress;

  @override
  List<Object> get props => [status, weather, city];
}
