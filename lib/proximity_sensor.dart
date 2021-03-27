// The Dart API for the plugin.

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static EventChannel _streamChannel = EventChannel('proximity_sensor');
  static Stream<int> get proximityEvents {
    return _streamChannel.receiveBroadcastStream().map((event) {
      developer.log("event =" + event.toString()); //debug XXX
      //return event.cast<int>()[0];
      return event; //test android
      //TODO : android 는 접근하면 0, 멀어지면 5
      //return event; //for ios TODO
    });
  }
}
