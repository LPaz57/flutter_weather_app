import 'dart:convert';
import 'package:flutter_openweather_app/models/forecast_model.dart';
import 'package:flutter_openweather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class WeatherApiClient {
  Future<WeatherResponse> getWeather(String city) async {
    if (city.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$city&appid=a521da38aea4b4552ca2c67479135cb5&units=metric'));
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } else {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=London&appid=a521da38aea4b4552ca2c67479135cb5&units=metric'));
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    }
  }

  Future<WeatherResponse> getWeatherByLocation(
      LocationData locationData) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=a521da38aea4b4552ca2c67479135cb5'));
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
        print('latitude:' + locationData.latitude.toString());
        print('longitude:' + locationData.longitude.toString());
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error: $error');
      if (error is http.Response) {
        print('Response body: ${error.body}');
      }
    }
    return Future.error('Error:');
    ;
  }

  Future<ForecastResponse> getForecast(String city) async {
    if (city.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$city&appid=a521da38aea4b4552ca2c67479135cb5&units=metric'));
      if (response.statusCode == 200) {
        return ForecastResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } else {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=London&appid=a521da38aea4b4552ca2c67479135cb5&units=metric'));
      if (response.statusCode == 200) {
        return ForecastResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    }
  }

  Future<ForecastResponse> getForecastByLocation(
      LocationData locationData) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=a521da38aea4b4552ca2c67479135cb5'));
    if (response.statusCode == 200) {
      return ForecastResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
