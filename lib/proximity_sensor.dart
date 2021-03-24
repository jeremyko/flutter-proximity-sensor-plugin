
import 'dart:async';

import 'package:flutter/services.dart';

class ProximitySensor {
  static const MethodChannel _channel =
      const MethodChannel('proximity_sensor');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
