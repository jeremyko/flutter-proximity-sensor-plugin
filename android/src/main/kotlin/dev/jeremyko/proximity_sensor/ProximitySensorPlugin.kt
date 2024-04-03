
package dev.jeremyko.proximity_sensor

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

////////////////////////////////////////////////////////////////////////////////////////////////////
class ProximitySensorPlugin: FlutterPlugin  {
  private lateinit var channel : EventChannel
  private lateinit var streamHandler : ProximityStreamHandler

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = EventChannel(flutterPluginBinding.binaryMessenger, "proximity_sensor")
    streamHandler = ProximityStreamHandler( flutterPluginBinding.applicationContext,
                                            flutterPluginBinding.binaryMessenger)
    channel.setStreamHandler(streamHandler)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setStreamHandler(null)
  }
}


