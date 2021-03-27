import 'package:flutter/material.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:developer' as developer;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
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
    developer.log("initState invoked");
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    developer.log("dispose invoked");
    _streamSubscription.cancel();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _streamSubscription = ProximitySensor.proximityEvents.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        developer.log("in main.dart : " + _isNear.toString());
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
