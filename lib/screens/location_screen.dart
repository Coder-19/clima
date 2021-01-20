import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather; // 4. getting the data into the constructor of
  // the location screen class and storing it in a variable named locationWeather

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // creating an object of the class WeatherModel
  WeatherModel weather = WeatherModel();

  int temperature;
  String message;
  String weatherIcon;
  var cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather); // 5. since LocationScreen is a statefull
    // widget so we need to used widget method to get the data being stored in the
    // location weather property and then this data is passed as input to the
    // updateUI() method
  }

  // 6. now the data stored in the location weather is passed as input to the
  // updateUI() method
  void updateUI(dynamic displayWeatherData) {
    setState(() {
      if (displayWeatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'unable to get the data';
        cityName = '';
        return; // the return statement will help the app to exit prematurly
      }

      // 7. now the components of the JSON data present in the displayWeatherData
      // is accessed using the method that we used to access data from the api and
      // stored in different variables declared outside this function but are accessible
      // throughout the  _LocationScreenState state
      double temp = displayWeatherData['main']['temp'];
      temperature = temp.toInt();
      message = weather.getMessage(temperature);
      var idValue = displayWeatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(idValue);
      cityName = displayWeatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );

                      if (typedCityName != null) {
                        var cityWeatherData =
                            await weather.getCityWeather(typedCityName);
                        updateUI(cityWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      // 8. now here we are using the value of the temperature that we got from the
                      // api and stored in the variable temperature
                      '$temperature°', // printing the value of temperature
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon, // used to get the icon according to the
                      // weather condition
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
