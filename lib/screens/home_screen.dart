import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'weather_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    if (weatherProvider.weather != null) {
      _controller.text = weatherProvider.weather!.cityName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://community.facer.io/uploads/short-url/wr0eHSo9b4ggNsZ14oAzO2GBSJY.png',
                  height: 70),
              SizedBox(
                height: 10,
              ),
              Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Enter City Name',
                    labelStyle: TextStyle(color: Colors.white)),
                cursorColor: Colors.white,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade700)),
                onPressed: () {
                  final cityName = _controller.text;
                  if (cityName.isNotEmpty) {
                    Provider.of<WeatherProvider>(context, listen: false)
                        .fetchWeather(cityName)
                        .then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WeatherScreen(cityName: cityName),
                        ),
                      );
                    });
                  }
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
