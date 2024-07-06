import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'dart:ui';

class WeatherScreen extends StatelessWidget {
  final String cityName;

  WeatherScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Center(
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            } else if (provider.weather == null) {
              return Center(child: Text('No weather data'));
            } else {
              final weather = provider.weather!;
              return AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.only(
                    bottom: 70, top: 70, left: 10, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            weather.cityName,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${weather.temperature.toStringAsFixed(1)}°C',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    weather.weatherCondition,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.water_drop, size: 30),
                              SizedBox(width: 8),
                              Text(
                                'Humidity: ${weather.humidity}%',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.air, size: 30),
                              SizedBox(width: 8),
                              Text(
                                'Wind Speed: ${weather.windSpeed} m/s',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Provider.of<WeatherProvider>(context, listen: false)
              .fetchWeather(cityName);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
