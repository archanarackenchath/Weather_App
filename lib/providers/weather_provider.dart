import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';
import '../services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService = WeatherService();

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(cityName);
      _saveLastSearchedCity(cityName);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastSearchedCity', cityName);
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final cityName = prefs.getString('lastSearchedCity');
    if (cityName != null) {
      await fetchWeather(cityName);
    }
  }
}
