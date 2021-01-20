import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// after this file go to location_screen.dart file

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel =
        WeatherModel(); // 1. creating a weather model instance and this weather model widget
    // is present in weather.dart class  present in weather.dart file
    var weatherData = await weatherModel
        .getLocationWeather(); // 2. using teh weatherModel instance to get the data
    // from the api used inside the getlocationWeather function  and storing it
    // in a variable named weatherData
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather:
              weatherData, // 3. passing the data that we have stored in
          // the weatherData to the locationWeather property present in locationScreen.dart file
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
