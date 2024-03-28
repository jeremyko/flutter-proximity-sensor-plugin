
package dev.jeremyko.proximity_sensor

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

////////////////////////////////////////////////////////////////////////////////////////////////////
class ProximitySensorPlugin: FlutterPlugin  {
  private lateinit var channel : EventChannel
  private lateinit var streamHandler : ProximityStreamHandler

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = EventChannel(flutterPluginBinding.binaryMessenger, "proximity_sensor")
    streamHandler = ProximityStreamHandler( flutterPluginBinding.applicationContext)
    channel.setStreamHandler(streamHandler)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setStreamHandler(null)
  }
}


