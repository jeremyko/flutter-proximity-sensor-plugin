//A Flutter app that depends on the plugin, and illustrates how to use it.
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // debug mode
      FlutterError.dumpErrorToConsole(details);
    } else {
      // production mode
      //details.exception, details.stack);
    }
  };

  runApp(MyApp());
}

////////////////////////////////////////////////////////////////////////////////
bool get isInDebugMode {
  bool inDebugMode = true;
  assert(inDebugMode = true);
  return inDebugMode;
}

////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

////////////////////////////////////////////////////////////////////////////////
class _MyAppState extends State<MyApp> {
  bool _isNear = false;
  StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _streamSubscription = ProximitySensor.proximityEvents.listen((int event) {
      setState(() {
        _isNear = (event == 0) ? false : true;
        //print("in main.dart : " + _isNear.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proximity Sensor Example'),
        ),
        body: Center(
          child: Text('proximity sensor, is near ?  $_isNear\n'),
        ),
      ),
    );
  }
}
