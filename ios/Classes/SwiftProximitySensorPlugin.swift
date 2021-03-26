import Flutter
import UIKit

//https://flutterdevs.com/blog/creating-a-flutter-plugin-for-android-and-ios-image-gallery/

public class SwiftProximityStreamHandler : NSObject,FlutterStreamHandler
{
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        let device =  UIDevice.current
        device.isProximityMonitoringEnabled = true
        //NotificationCenter.default.addObserver(forName: <#T##NSNotification.Name?#>, object: <#T##Any?#>, queue: <#T##OperationQueue?#>, using: <#T##(Notification) -> Void#>)
        NotificationCenter.default.addObserver(forName: UIDevice.proximityStateDidChangeNotification, object: device, queue: nil)
            { /* [weak self] */ (notification) in
                //guard let strongSelf = self else {  return }
                if let device = notification.object as? UIDevice {
                    print("from swift ...")
                    // Int32 type 인 경우 dart 에서 수신하는 것은 4 byte: this is dart code --> [0, 0, 0, 0]
                    // --> dart 에서 처리시 list 로! 즉, return new ProximityEvent(event.cast<int>()[0]);
                    // Int8  type 인 경우 dart 에서 수신하는 것은 1 byte: this is dart code --> [0]
                    // --> 이경우에는 dart 코드에서는 리스트로 처리 안해도 됨 !
                    //     return new ProximityEvent(event.cast<int>());
                    let onoff:Int8 = device.proximityState ? 0 : 1
                    print(onoff)
                    var data = Data()
                    withUnsafeBytes(of: onoff) {buffer in data.append(buffer.bindMemory(to: Int8.self))}
                    events(data)
                }
        }
        ////////////////
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(proximityStateDidChange),
                                               name: UIDevice.proximityStateDidChangeNotification,
                                               object: device)
         */
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        //TODO
        return nil
    }
    /*
    @objc func proximityStateDidChange(notification: Notification)
    {
        if let device = notification.object as? UIDevice {
            print("from swift ...")
            print( device)
        }
    }
    */
}

public class SwiftProximitySensorPlugin: NSObject, FlutterPlugin
{
    //static var observer:NotificationCenter = NotificationCenter.default
    static var stream_handler:SwiftProximityStreamHandler = SwiftProximityStreamHandler()
    static var channel:FlutterEventChannel = FlutterEventChannel()
    
    public static func register(with registrar: FlutterPluginRegistrar)
    {
        //----------------------------  FlutterEventChannel
        let channel = FlutterEventChannel.init(name: "proximity_sensor", binaryMessenger: registrar.messenger())
        channel.setStreamHandler(stream_handler)
        //----------------------------
        //auto generated code ...!
        /*
        let channel = FlutterMethodChannel(name: "proximity_sensor", binaryMessenger: registrar.messenger())
        let instance = SwiftProximitySensorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        */
 }
    
    /*
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        let device =  UIDevice.current
        device.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(observer)
    }
    */
    //////////////////////////////////////////////////////////////////////////////
    // - (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
    // Called if this plugin has been registered to receive `FlutterMethodCall`s.
    // @param call The method call command object.
    // @param result A callback for submitting the result of the call.
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       NSLog(call.method) //"listen"
        if call.method == "listen" {
        }
        //result("iOS " + UIDevice.current.systemVersion)
    }
}

