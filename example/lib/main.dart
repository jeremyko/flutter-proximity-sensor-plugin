import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

////////////////////////////////////////////////////////////////////////////////
void main() {
  runApp(MyApp());
}

////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

////////////////////////////////////////////////////////////////////////////////
class _MyAppState extends State<MyApp> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    // --------------------------------------------------------------------
    // You only need to make this call if you want to turn off the screen.
    // Add below permission in your AndroidManifest.xml file.
    //     <uses-permission android:name="android.permission.WAKE_LOCK"/>

    await ProximitySensor.setProximityScreenOff(true).onError((error, stackTrace) {
      print("could not enable screen off functionality");
      return null;
    });
    // --------------------------------------------------------------------

    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        // print("event = ${event}");
        _isNear = (event > 0) ? true : false;
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
