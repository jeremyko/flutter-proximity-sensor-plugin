// The Dart API for the plugin.

import 'dart:async';
import 'package:flutter/services.dart';

////////////////////////////////////////////////////////////////////////////////
//XXX stream 을 받게 추가한것
const EventChannel _stream_channel = EventChannel('proximity_sensor');

class ProximityEvent {
  final int onoff;
  ProximityEvent(this.onoff);
  bool getValue() => onoff == 0 ? true : false;

  @override
  String toString() => onoff == 0 ? 'true' : 'false';
}

/*
ProximityEvent _listToProximityEvent(int onoff) {
  return new ProximityEvent(onoff);
}
*/

/*
Stream<ProximityEvent> get proximityEvents {
  _sensor_events = _stream_channel
      .receiveBroadcastStream()
      //.map((event) => _listToProximityEvent(event.cast<int>()));
      .map((event) => new ProximityEvent(event.cast<int>()));
  return _sensor_events;
}
*/

////////////////////////////////////////////////////////////////////////////////
class ProximitySensor {
  static Stream<ProximityEvent> _sensor_events;
  static Stream<ProximityEvent> get proximityEvents {
    _sensor_events = _stream_channel.receiveBroadcastStream()
        //.map((event) => _listToProximityEvent(event.cast<int>()));
        //.map((event) => new ProximityEvent(event.cast<int>()));
        .map((event) {
      print("this is dart code --> " + event.toString());
      return new ProximityEvent(event.cast<int>()[0]); //XXX XXX XXX

      //return new ProximityEvent(event.cast<int>());
      //--> list<int,int..>
      //XXX XXX XXX error 안됨. list 임.!
      //--> Unhandled Exception: type 'CastList<int, int>' is not a subtype of type 'int'
    }); //XXX TEST

    //print(_sensor_events.toString()); //TEST --> 실행안됨
    /*
    print("return events...");
    print("this is dart code --> " + _sensor_events.toString());
    */
    return _sensor_events; //null error 방지  _stream_channel.receiveBroadcastStream() 로 만들어진것을 보내지 않으면 에러 발생
  }
  /*
  //XXX 이게 원래 있던것
  //static const MethodChannel _channel = const MethodChannel('proximity_sensor');

  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  static Future<bool> get proximityOn async {
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    // return version;
    final bool onoff = await _channel.invokeMethod('getProximityOnOff');
    return onoff;
  }
  */
}
