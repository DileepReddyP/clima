import 'package:clima/services/location.dart';
import 'package:clima/services/network.dart';
import 'package:clima/utilities/background_images.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  String city;
  String weatherIcon;
  String message;
  double temp;
  AssetImage bgimage;
  String unit = 'metric';

  init() async {
    AppLocation location = AppLocation();
    await location.getCurrentLocation();
    var data = await NetworkHelper()
        .getData(location.latitude, location.longitude, unit);
    var condition = data != null ? data['weather'][0]['id'] : null;
    city = data != null ? data['name'] : null;
    temp = data != null ? data['main']['temp'] : null;
    weatherIcon = getWeatherIcon(condition);
    message = getMessage(temp);
  }

  getCityData(qcity) async {
    var data = await NetworkHelper().getCityData(qcity, unit);
    var condition = data != null ? data['weather'][0]['id'] : null;
    city = data != null ? data['name'] : null;
    temp = data != null ? data['main']['temp'].toDouble() : null;
    weatherIcon = getWeatherIcon(condition);
    message = getMessage(temp);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      bgimage = images['drizzle'];
      return '🌩';
    } else if (condition < 400) {
      bgimage = images['rainy'];
      return '🌧';
    } else if (condition < 600) {
      bgimage = images['rainy'];
      return '☔️';
    } else if (condition < 700) {
      bgimage = images['snowy'];
      return '☃️';
    } else if (condition < 800) {
      bgimage = images['foggy'];
      return '🌫';
    } else if (condition == 800) {
      bgimage = images['sunny'];
      return '☀️';
    } else if (condition <= 804) {
      bgimage = images['cloudy'];
      return '☁️';
    } else {
      bgimage = images['huh'];
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for 🩳 and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
