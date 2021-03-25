
#import <Foundation/Foundation.h>
#import "ProximitySensorPlugin.h"

//#if __has_include(<proximity_sensor/proximity_sensor-Swift.h>)
//#import <proximity_sensor/proximity_sensor-Swift.h>
//#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
//#import "proximity_sensor-Swift.h"
//#endif

////////////////////////////////////////////////////////////////////////////////
@implementation ProximitySensorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    ProximityStreamHandler* handler = [[ProximityStreamHandler alloc] init];
    FlutterEventChannel* channel = [FlutterEventChannel eventChannelWithName:@"proximity_sensor"
                                                             binaryMessenger:[registrar messenger]];
    [channel setStreamHandler:  handler];
    //messenger returns a `FlutterBinaryMessenger` for creating Dart/iOS communication
    //channels to be used by the plugin.
    
    //---------------------------------------------------------- TODO
    //[SwiftProximitySensorPlugin registerWithRegistrar:registrar];
}
@end

////////////////////////////////////////////////////////////////////////////////
NSNotificationCenter* observer;
@implementation ProximityStreamHandler

 //Sets up an event stream and begin emitting events.
 //Invoked when the first listener is registered with the Stream associated to
 //this channel on the Flutter side.
 
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    
    UIDevice* device = [UIDevice currentDevice];
    //먼저 센서 값을 일단 보내고..
    device.proximityMonitoringEnabled = YES;
    int onoff = device.proximityState ? 0 : 1 ;
    NSMutableData * data = [NSMutableData dataWithCapacity:  1 *  sizeof(int)];
    [data appendBytes: &onoff length:sizeof(int)];
    events([FlutterStandardTypedData typedDataWithInt32:data]); //function pointer..
    
    //queue 에 저장해서 계속 전송하게 한다
    NSOperationQueue * sensor_queue = [ NSOperationQueue mainQueue]; //Returns the operation queue associated with the main thread.
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceProximityStateDidChangeNotification
                                                    object:nil
                                                    queue:sensor_queue
                                                    //queue:nil //TEST XXX
                                                    usingBlock: ^(NSNotification* noti){
        UIDevice* device = [UIDevice currentDevice];
        int onoff = device.proximityState ? 0 : 1 ;
        NSLog(@"onoff=%d\n", onoff);
        
        
        NSMutableData * data = [NSMutableData dataWithCapacity:  1 *  sizeof(int)];
        [data appendBytes: &onoff length:sizeof(int)];
        events([FlutterStandardTypedData typedDataWithInt32:data]); //function pointer..
    }  ] ;
    return nil;
}

//Tears down an event stream.
//Invoked when the last listener is deregistered from the Stream associated to
//this channel on the Flutter side.
- (FlutterError *)onCancelWithArguments:(id)arguments{
    UIDevice* device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                        name:UIDeviceProximityStateDidChangeNotification
                                        object:nil];
    return nil;
}
@end
