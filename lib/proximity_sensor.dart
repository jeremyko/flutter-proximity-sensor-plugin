import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static EventChannel _streamChannel = EventChannel('proximity_sensor');
  static Stream<int> get events {
    return _streamChannel.receiveBroadcastStream().map((event) {
      developer.log("sensor value -> " + event.toString());
      return event;
    });
  }
}
