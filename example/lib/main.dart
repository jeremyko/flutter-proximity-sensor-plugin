//A Flutter app that depends on the plugin, and illustrates how to use it.
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:flutter/services.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //String _platformVersion = 'Unknown';
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  bool _proximityOn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    //TODO null check. --> ProximitySensor.proximityEvents
    _streamSubscriptions
        .add(ProximitySensor.proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximityOn = event.getValue();
        print("in main.dart : " + _proximityOn.toString());
      });
    }));

    /*
    //String platformVersion;
    bool proximityOn = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await ProximitySensor.platformVersion;
      //proximityOn = await ProximitySensor.proximityOn;
    } on PlatformException {
      //TODO
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      //_platformVersion = platformVersion;
      _proximityOn = proximityOn;
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proximity Sensor example'),
        ),
        body: Center(
          child: Text('proximity : $_proximityOn\n'),
        ),
      ),
    );
  }
}
