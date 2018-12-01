import 'package:flutter/material.dart';
import 'package:weather_app_2/models/models.dart';
import 'package:weather_app_2/widgets/static_text_widgets.dart';

class TodayWeatherPage extends StatefulWidget {
  final String city;
  final WeatherModel weatherModel;

  const TodayWeatherPage({Key key, this.city, this.weatherModel})
      : super(key: key);

  @override
  _TodayWeatherPageState createState() => _TodayWeatherPageState();
}

class _TodayWeatherPageState extends State<TodayWeatherPage> {
  DateTime selectedTime;
  int selectedHour;
  WeatherData weatherData;
  bool hasChangedTime = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherData = getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              CityTitle(
                cityName: widget.city,
              ),
              DayText(date: widget.weatherModel.currently.time),
              Align(
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconSize: 20.0,
                    value:
                        hasChangedTime ? selectedHour : getCurrentTimeValue(),
                    items: getDropDownMenuItems(),
                    style:
                        TextStyle(fontFamily: 'Quicksand', color: Colors.black),
                    onChanged: (val) {
                      setState(() {
                        if (val != getCurrentTimeValue()) {
                          selectedHour = val;
                          hasChangedTime = true;
                        } else {
                          selectedHour = val;
                          hasChangedTime = false;
                        }
                        print(selectedHour);
                        print(getWeatherData());
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: WeatherRow(
            summary: getWeatherData().summary,
            temp: getWeatherData().temperature,
            icon: getWeatherData().icon,
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: DetailsRow(
              percip: getWeatherData().precipProbability,
              windSpeed: getWeatherData().windSpeed,
              humidity: getWeatherData().humidity,
            )),
      ],
    );
  }

  int getCurrentTimeValue() {
    DateTime time = widget.weatherModel.currently.time;
    List<int> abbrTimes = [
      7,
      12,
      17,
      20,
    ];
    int abbrTime;
    abbrTimes.forEach((d) {
      if (d.compareTo(time.hour).isNegative) {
        abbrTime = d;
      }
    });
    return abbrTime;
  }

  List<DropdownMenuItem<int>> getDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = [
      DropdownMenuItem(
          value: 7,
          child: new Text(
            'Morning',
          )),
      DropdownMenuItem(
          value: 12,
          child: new Text(
            'Noon',
          )),
      DropdownMenuItem(
          value: 17,
          child: new Text(
            'Evening',
          )),
      DropdownMenuItem(
          value: 20,
          child: new Text(
            'Night',
          )),
    ];
    List<DropdownMenuItem<int>> allowedItems = [];
    items.forEach((d) {
      if (!d.value.compareTo(getCurrentTimeValue()).isNegative) {
        allowedItems.add(d);
      }
    });
    return allowedItems;
  }

  WeatherData getWeatherData() {
    WeatherData selectedData;
    if (hasChangedTime) {
      DateTime time = getSelectedTime();
      List<WeatherData> hourlyData = widget.weatherModel.hourly;
//debugger();
      hourlyData.forEach((d) {
        if (time == d.time) {
          selectedData = d;
        }
//        debugger();
        return selectedData;
      });
    } else {
      var data = widget.weatherModel.currently;
      selectedData = WeatherData(
        apparentTemperature: data.apparentTemperature,
        humidity: data.humidity,
        icon: data.icon,
        precipProbability: data.precipProbability,
        summary: data.summary,
        temperature: data.temperature,
        time: data.time,
        windSpeed: data.windSpeed,
      );
    }
//    debugger();
    return selectedData;
  }

  DateTime getSelectedTime() {
    DateTime currentTime = widget.weatherModel.currently.time;
    DateTime selectedTime = DateTime(
        currentTime.year, currentTime.month, currentTime.day, selectedHour);
    return selectedTime;
  }
}


class OtherdayWeatherPage extends StatefulWidget {
  final String city;
  final WeatherModel weatherModel;
  final int index;
  const OtherdayWeatherPage({Key key, this.city, this.weatherModel, this.index})
      : super(key: key);

  @override
  _OtherdayWeatherPageState createState() => _OtherdayWeatherPageState();
}


class _OtherdayWeatherPageState extends State<OtherdayWeatherPage> {

  WeatherData weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherData = getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              CityTitle(
                cityName: widget.city,
              ),
              DayText(date: widget.weatherModel.daily[widget.index].time),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: WeatherRow(
            summary: getWeatherData().summary,
            temp: getWeatherData().temperature,
            icon: getWeatherData().icon,
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: DetailsRow(
              percip: getWeatherData().precipProbability,
              windSpeed: getWeatherData().windSpeed,
              humidity: getWeatherData().humidity,
            )),
      ],
    );
  }

  WeatherData getWeatherData() {
    var data = widget.weatherModel.daily[widget.index];
    WeatherData selectedData = WeatherData(
      apparentTemperature: data.apparentTemperature,
      humidity: data.humidity,
      icon: data.icon,
      precipProbability: data.precipProbability,
      summary: data.summary,
      temperature: data.temperature,
      time: data.time,
      windSpeed: data.windSpeed,
    );
    return selectedData;
  }

}
