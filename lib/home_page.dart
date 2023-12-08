import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_mini/service/weather_service.dart';
import 'package:weather_mini/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService('41aa18abb8974c0ea27098038f6feb1b');
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/kyn.json";
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'fog':
        return 'assets/bulut.json';
      case 'shower rain':
        return 'assets/kyn_bulut.json';
      case 'thunderstorm':
        return 'assets/chagylgan.json';
      case 'clear':
        return 'assets/kyn.json';
      default:
        return 'assets/kyn.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 136, 192),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.name ?? " loading city..."),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),
            Text('${_weather?.temperature.round()}C'),
            Text('${_weather?.mainCondition}')
          ],
        ),
      ),
    );
  }
}
