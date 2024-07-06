import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const _apiKey = '33b8ad02c1ebee55f3f4b58c4bc8bf75';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey'));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
