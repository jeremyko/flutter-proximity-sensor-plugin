import 'dart:async';
import 'package:flutter/services.dart';

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static EventChannel _streamChannel = EventChannel('proximity_sensor');
  static MethodChannel _methodChannel =
      MethodChannel('proximity_sensor_enable');

  static Stream<int> get events {
    return _streamChannel.receiveBroadcastStream().map((event) {
      return event;
    });
  }

  static Future<void> setProximityScreenOff(bool enabled) async {
    await _methodChannel
        .invokeMethod<void>('enableProximityScreenOff', <String, dynamic>{
      'enabled': enabled,
    });
  }
}
