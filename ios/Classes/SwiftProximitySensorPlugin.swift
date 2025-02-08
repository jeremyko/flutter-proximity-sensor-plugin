import Flutter
import UIKit

//==============================================================================
public class SwiftProximityStreamHandler : NSObject,FlutterStreamHandler
{
    let notiCenter = NotificationCenter.default
    let device =  UIDevice.current
    
    public func onListen(withArguments arguments: Any?,
                         eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // Apple's  weird way: 
        // https://developer.apple.com/documentation/uikit/uidevice/isproximitymonitoringenabled
        // To determine if proximity monitoring is available, attempt to enable it. 
        // If the value of the isProximityMonitoringEnabled property remains false, 
        // proximity monitoring isn’t available.
        device.isProximityMonitoringEnabled = true
        if (device.isProximityMonitoringEnabled == false) {
            //sensor is unavailable
            return nil
        }

        //sensor is available
        notiCenter.addObserver(forName: UIDevice.proximityStateDidChangeNotification,
                                object: device,
                                queue: nil,
                                using : { (notification) in
                                            if let device = notification.object as? UIDevice {
                                                // true -> something is near
                                                let onoff:Int8 = device.proximityState ? 1 : 0
                                                events(onoff)
                                            }
                                        })
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        notiCenter.removeObserver(self)
        device.isProximityMonitoringEnabled = false
        
        return nil
    }
}

//==============================================================================
public class SwiftProximitySensorPlugin: NSObject, FlutterPlugin
{
    static var stream_handler:SwiftProximityStreamHandler = SwiftProximityStreamHandler()
    static var eventChannel:FlutterEventChannel = FlutterEventChannel()
    static var methodChannel:FlutterMethodChannel = FlutterMethodChannel()
    
    public static func register(with registrar: FlutterPluginRegistrar)    {
        let eventChannel = FlutterEventChannel.init(name: "proximity_sensor", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(stream_handler)

        let methodChannel = FlutterMethodChannel(name: "proximity_sensor_enable", binaryMessenger: registrar.messenger())

        let instance = SwiftProximitySensorPlugin()
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(FlutterMethodNotImplemented)
  }
}

