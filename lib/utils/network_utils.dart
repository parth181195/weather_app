import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_2/models/models.dart';
import 'package:weather_app_2/utils/api_config.dart';

class NetworkUtils {
  Future<WeatherModel> GetWeather(Position pos) async {
    if (pos != null) {
      String _urlDarkSky =
          'https://api.darksky.net/forecast/${ApiConfig.apiKeyDarksky}/${pos.latitude},${pos.longitude}';
      print(_urlDarkSky);
      final responseWeather =
          await http.get(_urlDarkSky).then((res) => json.decode(res.body));
      return WeatherModel.fromJson(responseWeather);
    }
  }

  Future<String> getCity(Position pos) async {
    if (pos!= null) {
      String _urlPlaces =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${pos.latitude},${pos.longitude}&key=AIzaSyDM1WVwCdDFeLik_-Pzjo1vkoFiaAUY8AI';
      final response = await http
          .get(Uri.parse(_urlPlaces))
          .then((res) => res.body)
          .then(json.decode);
      String cityName;
      List addresComponents =response['results'][0]['address_components'];
      addresComponents.forEach((data){
        List types = data['types'];
        if(types.indexOf('administrative_area_level_2') != -1){
          cityName = data['long_name'];
        }
      });
      return cityName;
    }
  }
}
