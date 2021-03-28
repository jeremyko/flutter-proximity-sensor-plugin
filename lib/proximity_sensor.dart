import 'dart:async';
import 'package:flutter/services.dart';

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static EventChannel _streamChannel = EventChannel('proximity_sensor');
  static Stream<int> get events {
    return _streamChannel.receiveBroadcastStream().map((event) {
      return event;
    });
  }
}
