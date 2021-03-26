import Flutter
import UIKit

//==============================================================================
public class SwiftProximityStreamHandler : NSObject,FlutterStreamHandler
{
    let notiCenter = NotificationCenter.default
    let device =  UIDevice.current
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        device.isProximityMonitoringEnabled = true
        if (device.isProximityMonitoringEnabled == false) {
            return FlutterError(code: "UNAVAILABLE",
                                message: "proximity sensor unavailable", 
                                details: nil)
        }
        
        notiCenter.addObserver(forName: UIDevice.proximityStateDidChangeNotification,
                                object: device,
                                queue: nil,
                                using : { (notification) in
                                            if let device = notification.object as? UIDevice {
                                                let onoff:Int8 = device.proximityState ? 1 : 0
                                                var data = Data()
                                                withUnsafeBytes(of: onoff) {
                                                    buffer in data.append(buffer.bindMemory(to: Int8.self))}
                                                
                                                events(data)
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
    static var channel:FlutterEventChannel = FlutterEventChannel()
    
    public static func register(with registrar: FlutterPluginRegistrar)    {
        let channel = FlutterEventChannel.init(name: "proximity_sensor", binaryMessenger: registrar.messenger())
        channel.setStreamHandler(stream_handler)
     }
}

