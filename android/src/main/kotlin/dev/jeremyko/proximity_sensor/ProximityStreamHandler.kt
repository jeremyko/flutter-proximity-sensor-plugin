package dev.jeremyko.proximity_sensor

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import java.io.IOException
import java.lang.UnsupportedOperationException

////////////////////////////////////////////////////////////////////////////////////////////////////
class ProximityStreamHandler(
        private val applicationContext: Context,
        private val messenger: BinaryMessenger
): EventChannel.StreamHandler, SensorEventListener {

    private var eventSink: EventChannel.EventSink? = null
    private lateinit var sensorManager: SensorManager
    private var proximitySensor: Sensor? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        sensorManager =  applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        proximitySensor = sensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY) ?:
            throw UnsupportedOperationException("proximity sensor unavailable")

        sensorManager.registerListener(this, proximitySensor, SensorManager.SENSOR_DELAY_NORMAL)
    }

    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this, proximitySensor)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        val distance = event ?.values?.get(0)?.toInt() //get distance
        if (distance != null) {
            if(distance > 0) {
                // distance > 0 , nothing is near
                eventSink ?.success(0)
            }else{
                // distance == 0, something is near
                eventSink ?.success(1)
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        //do nothing
    }
}