# proximity_sensor

https://pub.dev/packages/proximity_sensor

simple and easy to use flutter plugin package for proximity sensor (only)

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  proximity_sensor:
```

In your library add the following import:

```dart
import 'package:proximity_sensor/proximity_sensor.dart';
```

## Note

Android 12 and higher are required to specify an explicit value for `android:exported`  
This is an example.

    <activity
        android:exported="true"
        ....

Regarding permissions, you may need the following settings in your `AndroidManifest.xml` file:

    <uses-permission android:name="android.hardware.sensor.proximity"/>
    <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>

NB: the WAKE_LOCK permission is only needed if you run `setProximityScreenOff(true)` before listening to events

**Some recent devices use virtual proximity sensors. There are no physical sensors. I found it hard to trust the sensor information in this case.**
