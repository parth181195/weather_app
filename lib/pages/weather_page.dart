import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2/models/models.dart';
import 'package:weather_app_2/pages/loader.dart';
import 'package:weather_app_2/utils/network_utils.dart';
import 'package:weather_app_2/widgets/interactive_widgets.dart';
import 'package:weather_app_2/widgets/static_text_widgets.dart';

class WeatherPage extends StatefulWidget {
  Position position;

  WeatherPage({this.position});

  @override
  WeatherPageState createState() {
    return new WeatherPageState();
  }
}

class WeatherPageState extends State<WeatherPage> {
  NetworkUtils networkUtils = NetworkUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<MergedData>(
            future: Future.wait([
              networkUtils.GetWeather(widget.position),
              networkUtils.getCity(widget.position)
            ])
                .then((res) => MergedData(weatherModel: res[0], city: res[1]))
                .catchError((e) => print(e)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                  EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .padding
                      .top),
                  child: PageView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return TodayWeatherPage(
                            city: snapshot.data.city,
                            weatherModel: snapshot.data.weatherModel,
                          );
                        }
                        return OtherdayWeatherPage(
                          index: index,
                          city: snapshot.data.city,
                          weatherModel: snapshot.data.weatherModel,
                        );
                      }),
                );
              } else {
                return Loader();
              }
            }));
  }
}
