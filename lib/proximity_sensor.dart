// The Dart API for the plugin.

import 'dart:async';
import 'package:flutter/services.dart';

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static EventChannel _streamChannel = EventChannel('proximity_sensor');
  static Stream<int> get proximityEvents {
    return _streamChannel.receiveBroadcastStream().map((event) {
      return event.cast<int>()[0];
    });
  }
}
