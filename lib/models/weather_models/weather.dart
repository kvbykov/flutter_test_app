import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final double temperature;
  final double weathercode;

  const Weather({
    required this.temperature,
    required this.weathercode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  static const empty = Weather(
    temperature: 0,
    weathercode: 0,
  );

  @override
  List<Object> get props => [temperature, weathercode];
}
