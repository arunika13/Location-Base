import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterweatherapigeolocation/weather.dart';
import 'package:flutterweatherapigeolocation/weather_screen.dart';
import 'location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getLocation() async {
    LocationService s = LocationService();
    await s.getCurrentLocation();
  }

  WeatherService? weatherService = WeatherService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  void getWeather() async {
    await weatherService?.getWeatherData();

    Navigator.push(context,
        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
      return WeatherScreen(weatherService: weatherService!);
    }));
  }

  @override
  Widget build(BuildContext context) {
    //getLocation();
    return Container(
      child: const SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
