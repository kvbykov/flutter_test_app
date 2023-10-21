import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_case/data/api_utils/weather_api_errors.dart';
import 'package:test_case/data/api_utils/weather_api_paths.dart';
import 'package:test_case/models/weather_models/models.dart';

class WeatherApiClient {
  final http.Client _client;

  WeatherApiClient({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri =
        Uri.https(WeatherApiPaths.weatherBaseUrl, WeatherApiPaths.forecast, {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    final response = await _client.get(uri);

    if (response.statusCode != 200) throw WeatherRequestException();
    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    if (!jsonMap.containsKey('current_weather')) {
      throw WeatherNotFoundException();
    }
    final weatherMap = jsonMap['current_weather'] as Map<String, dynamic>;
    return Weather.fromJson(weatherMap);
  }

  Future<Location> getLocation({
    required String city,
  }) async {
    final uri = Uri.https(
        WeatherApiPaths.geocodingBaseUrl, WeatherApiPaths.locationSearch, {
      'name': city,
      'count': '1',
    });

    final response = await _client.get(uri);
    if (response.statusCode != 200) throw LocationRequestException();
    final jsonMap = jsonDecode(response.body) as Map;
    if (!jsonMap.containsKey('results')) throw LocationNotFoundException();
    final results = jsonMap['results'] as List;
    if (results.isEmpty) throw LocationNotFoundException();
    return Location.fromJson(results.first as Map<String, dynamic>);
  }
}
