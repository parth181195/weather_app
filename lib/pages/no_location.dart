import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather_app_2/main.dart';
import 'package:weather_app_2/utils/custome_route.dart';

class NoLocation extends StatefulWidget {
  final bool askForPermission;

  NoLocation({this.askForPermission});

  @override
  NoLocationState createState() {
    return new NoLocationState();
  }
}

class NoLocationState extends State<NoLocation> {
  Permission permission;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.askForPermission);
    if (widget.askForPermission) {
      initPlatformState();
    }
  }

  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    await SimplePermissions.checkPermission(Permission.AccessCoarseLocation)
        .then((bool) async {
      print(bool);
      if (!bool) {
        await SimplePermissions.requestPermission(
                Permission.AccessCoarseLocation)
            .then((status) {
          print(status);

          Navigator.pushReplacement(
              context, MyCustomRoute(builder: (context) => WeatherHome()));
        });
      }
    });
    await SimplePermissions.checkPermission(Permission.AccessFineLocation)
        .then((bool) async {
      print(bool);
      if (!bool) {
        await SimplePermissions.requestPermission(Permission.AccessFineLocation)
            .then((status) {
          print(status);
          Navigator.pushReplacement(
              context, MyCustomRoute(builder: (context) => WeatherHome()));
        });
      }
    });
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ErrPage());
  }
}

class ErrPage extends StatelessWidget {
  final String errMessage =
      'Make Sure that location services are running & you have a wokring internet connection and try again';

  final String errTitle = 'Oh snap!';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                  child: AspectRatio(
                      aspectRatio: 1.823,
                      child: FadeInImage(
                          image: AssetImage('assets/images/no_location.png'),
                          placeholder: MemoryImage(kTransparentImage)))),
              Text(
                errTitle,
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Text(
                  errMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Quicksand', fontWeight: FontWeight.w300),
                ),
              ),
              RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: Text('Retry',style: TextStyle(fontFamily: 'Quicksand',color: Colors.white),),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MyCustomRoute(builder: (context) => WeatherHome()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
