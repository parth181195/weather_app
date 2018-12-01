import 'dart:async';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionUtils {
  Future<ConnectivityResult>checkConnectvity() async{
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    return connectivity;
  }
}