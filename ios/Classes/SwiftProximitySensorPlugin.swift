import Flutter
import UIKit

//https://flutterdevs.com/blog/creating-a-flutter-plugin-for-android-and-ios-image-gallery/
/*
public class SwiftProximitySensorPlugin: NSObject, FlutterPlugin {
  
    public static func register(with registrar: FlutterPluginRegistrar) {
    //UIDevice.current.isProximityMonitoringEnabled = true
    
    let channel = FlutterMethodChannel(name: "proximity_sensor", binaryMessenger: registrar.messenger())
    let instance = SwiftProximitySensorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
  //////////////////////////////////////////////////////////////////////////////
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //result("iOS " + UIDevice.current.systemVersion)
    //getProximityOnOff
    //result(UIDevice.current.proximityState)
    
    if call.method == "getProximityOnOff" {
        result(UIDevice.current.proximityState)
    }
    
    //FlutterStreamHandler
  }
}
*/
