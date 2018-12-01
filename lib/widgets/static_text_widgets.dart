import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CityTitle extends StatelessWidget {
  final String cityName;

  CityTitle({this.cityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        '$cityName',
        style: TextStyle(fontFamily: 'Quicksand', fontSize: 30.0),
      ),
    );
  }
}

class DayText extends StatelessWidget {
  final DateTime date;

  DayText({this.date});

  String getAbbrDay() {
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime whatEver = DateTime.now().add(Duration(days: 2));
    if (today.day == date.day) {
      return 'Today';
    } else if (tomorrow.day == date.day) {
      return 'Tomorrow';
    } else if (whatEver.day == date.day) {
      return 'Whatever';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        '${getAbbrDay()}',
        style: TextStyle(fontFamily: 'Quicksand', fontSize: 20.0),
      ),
    );
  }
}

class WeatherRow extends StatefulWidget {
  final double temp;
  final String summary;
  final String icon;

  const WeatherRow({Key key, this.temp, this.summary, this.icon})
      : super(key: key);

  @override
  WeatherRowState createState() {
    return new WeatherRowState();
  }
}

class WeatherRowState extends State<WeatherRow> {
  bool isF = true;
String getShortSummery(){
  List<String> summeryList = widget.summary.split(' ');
  if(summeryList.length > 2){
    return summeryList[0]+' '+summeryList[1];
  }
  return widget.summary;
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20.0),
              constraints: BoxConstraints(maxHeight: 150.0, maxWidth: 150.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: FadeInImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/icons/${widget.icon}.png'),
                    placeholder: MemoryImage(kTransparentImage)),
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                isF = !isF;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    isF
                        ? '${widget.temp}°F'
                        : '${((5 / 9) * (widget.temp - 32)).toStringAsFixed(2)}°C',
                    style: TextStyle(fontFamily: 'Quicksand', fontSize: 40.0),
                  ),
                  Text(
                    '${getShortSummery()}',
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontFamily: 'Quicksand', fontSize: 15.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final double percip;
  final double windSpeed;
  final double humidity;

  const DetailsRow({Key key, this.percip, this.windSpeed, this.humidity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        DetailColumn(
          image: 'wind_speed',
          data: (windSpeed*1.609).round(),
          unit: 'KM/H',
        ),
        DetailColumn(
          image: 'percip',
          data: (percip).round(),
          unit: '%',
        ),
        DetailColumn(
          image: 'humidity',
          data: (humidity*100).round(),
          unit: '%',
        )
      ],
    );
  }
}

class DetailColumn extends StatelessWidget {
  final String image;
  final int data;
final String unit;
  const DetailColumn({Key key, this.image, this.data, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
                constraints: BoxConstraints(maxHeight: 30.0, maxWidth: 30.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FadeInImage(
                      image: AssetImage('assets/images/icons/$image.png'),
                      placeholder: MemoryImage(kTransparentImage)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 15.0),
            child: Text(
              '$data',
              style: TextStyle(fontFamily: 'Quicksand'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '$unit',
              style: TextStyle(fontFamily: 'Quicksand',fontSize: 12.0,color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
