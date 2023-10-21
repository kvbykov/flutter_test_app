import 'package:test_case/data/api/weather_api_client.dart';
import 'package:test_case/models/weather_models/weather.dart';

class WeatherRepository {
  final WeatherApiClient _client;

  WeatherRepository({
    WeatherApiClient? client,
  }) : _client = client ?? WeatherApiClient();

  Future<Weather> getWeather(String city) async {
    final location = await _client.getLocation(city: city);
    final weather = await _client.getWeather(
        latitude: location.latitude, longitude: location.longitude);
    return weather;
  }
}
