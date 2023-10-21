part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class WeatherSearchSubmitted extends WeatherEvent {
  final String city;

  const WeatherSearchSubmitted(this.city);

  @override
  List<Object> get props => [city];
}

final class _WeatherAutoUpdated extends WeatherEvent {}
