import 'dart:developer';

class MergedData {
  final WeatherModel weatherModel;
  final String city;

  MergedData({
    this.weatherModel,
    this.city,
  });
}

class WeatherModel {

  double latitude;
  double longitude;
  String timezone;
  WeatherData currently;
  List<WeatherData> hourly;
  List<WeatherData> daily;
  double offset;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.timezone,
    this.currently,
    this.hourly,
    this.daily,
    this.offset,
  });

  static WeatherModel fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      timezone: json['timezone'],
      currently: WeatherData.fromJson(json['currently']),
      hourly: List.generate(json['hourly']['data'].length, (index) {
        return WeatherData.fromJson(json['hourly']['data'][index]);
      }),
      daily: List.generate(json['daily']['data'].length, (index) {
        if (index < 3) {
          return WeatherData.fromJson(json['daily']['data'][index]);
        }
      }),
      offset: double.parse(json['offset'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
        'currently': currently,
        'hourly': hourly,
        'daily': daily,
        'offset': offset,
      };
}

class WeatherData {
  DateTime time;
  String summary;
  String icon;
  double precipProbability;
  double temperature;
  double apparentTemperature;
  double humidity;
  double windSpeed;

  WeatherData(
      {this.time,
      this.summary,
      this.icon,
      this.precipProbability,
      this.temperature,
      this.apparentTemperature,
      this.humidity,
      this.windSpeed});

  static WeatherData fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
      summary: json['summary'],
      icon: json['icon'],
      precipProbability: double.parse(json['precipProbability'].toString()),
      temperature: double.parse(json['temperature'] != null ? json['temperature'].toString() :json['temperatureMax'].toString() ),
      apparentTemperature: double.parse(json['apparentTemperature'] != null ? json['apparentTemperature'].toString() :json['apparentTemperatureMax'].toString() ),
      humidity: double.parse(json['humidity'].toString()),
      windSpeed: double.parse(json['windSpeed'].toString()),
    );
  }
}
