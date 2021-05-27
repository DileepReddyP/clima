import 'dart:convert';
import 'package:clima/utilities/apikey.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future getData(lat, lon, unit) async {
    Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': apiKey,
        'units': unit.toString(),
      },
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future getCityData(city, unit) async {
    Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': city,
        'appid': apiKey,
        'units': unit,
      },
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}
