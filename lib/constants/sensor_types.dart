/// Android Sensor Types
/// Values correspond to those of [android.hardware.Sensor] platform class
///
/// More details at:
/// https://developer.android.com/reference/android/hardware/Sensor
enum SensorType {
  /// A constant describing an accelerometer sensor type
  accelerometer,

  /// A constant describing a magnetic field sensor type
  magneticField,

  /// A constant describing an orientation sensor type
  orientation,

  /// A constant describing a gyroscope sensor type
  gyroscope,

  /// A constant describing a light sensor type
  light,

  /// A constant describing a pressure sensor type
  pressure,

  /// A constant describing a temperature sensor type
  temperature,

  /// A constant describing a proximity sensor type
  proximity,

  /// A constant describing a gravity sensor type
  gravity,

  /// A constant describing a linear acceleration sensor type
  linearAcceleration,

  /// A constant describing a rotation vector sensor type
  rotationVector,

  /// A constant describing a relative humidity sensor type
  relativeHumidity,

  /// A constant describing an ambient temperature sensor type
  ambientTemperature,

  /// A constant describing an uncalibrated magnetic field sensor type.
  ///
  /// Similar to TYPE_MAGNETIC_FIELD but the hard iron calibration
  /// (device calibration due to distortions that arise from magnetized iron,
  /// steel or permanent magnets on the device) is not considered in the given
  /// sensor values.
  ///
  /// However, such hard iron bias values are returned to you separately in the
  /// result SensorEvent.values so you may use them for custom calibrations.
  /// Also, no periodic calibration is performed (i.e. there are no
  /// discontinuities in the data stream while using this sensor) and
  /// assumptions that the magnetic field is due to the Earth's poles is avoided,
  /// but factory calibration and temperature compensation have been performed.
  magneticFieldUncalibrated,

  /// A constant describing an uncalibrated rotation vector sensor type.
  ///
  /// Identical to [rotationVector] except that it doesn't use the geomagnetic
  /// field. Therefore the Y axis doesn't point north, but instead to some other
  /// reference, that reference is allowed to drift by the same order of
  /// magnitude as the gyroscope drift around the Z axis.
  ///
  /// In the ideal case, a phone rotated and returning to the same real-world
  /// orientation should report the same game rotation vector (without using the
  /// earth's geomagnetic field).
  /// However, the orientation may drift somewhat over time.
  gameRotationVector,

  /// A constant describing an uncalibrated gyroscope sensor type.
  ///
  /// Similar to TYPE_GYROSCOPE but no gyro-drift compensation has been performed to adjust the given sensor values. However, such gyro-drift bias values are returned to you separately in the result SensorEvent.values so you may use them for custom calibrations.
  /// Factory calibration and temperature compensation is still applied to the rate of rotation (angular speeds).
  gyroscopeUncalibrated,

  /// A constant describing a significant motion trigger sensor.
  ///
  /// It triggers when an event occurs and then automatically disables itself.
  /// The sensor continues to operate while the device is asleep and will
  /// automatically wake the device to notify when significant motion is detected.
  ///
  /// The application does not need to hold any wake locks for this sensor to
  /// trigger. This is a wake up sensor.
  significantMotion,

  /// A constant describing a step detector sensor.
  ///
  /// A sensor of this type triggers an event each time a step is taken by the
  /// user. The only allowed value to return is 1.0 and an event is generated
  /// for each step. Like with any other event, the timestamp indicates when the
  /// event (here the step) occurred, this corresponds to when the foot hit the
  /// ground, generating a high variation in acceleration.
  ///
  /// This sensor is only for detecting every individual step as soon as it is
  /// taken, for example to perform dead reckoning. If you only need aggregate
  /// number of steps taken over a period of time, register for [stepCounter]
  /// instead.
  ///
  /// It is defined as a REPORTING_MODE_SPECIAL_TRIGGER sensor.
  /// This sensor requires permission android.permission.ACTIVITY_RECOGNITION.
  stepDetector,

  /// A constant describing a step counter sensor.
  ///
  /// A sensor of this type returns the number of steps taken by the user since
  /// the last reboot while activated.
  /// The value is returned as a float (with the fractional part set to zero)
  /// and is reset to zero only on a system reboot.
  /// The timestamp of the event is set to the time when the last step for that
  /// event was taken.
  /// This sensor is implemented in hardware and is expected to be low power.
  /// If you want to continuously track the number of steps over a long period
  /// of time, do NOT unregister for this sensor, so that it keeps counting
  /// steps in the background even when the AP is in suspend mode and report the
  /// aggregate count when the AP is awake. Application needs to stay registered
  /// for this sensor because step counter does not count steps if it is not activated.
  /// This sensor is ideal for fitness tracking applications.
  /// It is defined as an REPORTING_MODE_ON_CHANGE sensor.
  /// This sensor requires permission android.permission.ACTIVITY_RECOGNITION.
  stepCounter,

  /// A constant describing a geo-magnetic rotation vector.
  /// Similar to [rotationVector], but using a magnetometer instead of using a
  /// gyroscope. This sensor uses lower power than the other rotation vectors,
  /// because it doesn't use the gyroscope.
  /// However, it is more noisy and will work best outdoors.
  geomagneticRotationVector,

  /// A constant describing a heart rate monitor.
  /// The reported value is the heart rate in beats per minute.
  /// The reported accuracy represents the status of the monitor during the
  /// reading. See the SENSOR_STATUS_* constants in SensorManager for more details
  /// on accuracy/status values.
  /// In particular, when the accuracy is SENSOR_STATUS_UNRELIABLE or SENSOR_STATUS_NO_CONTACT,
  /// the heart rate value should be discarded.
  /// This sensor requires permission android.permission.BODY_SENSORS.
  /// It will not be returned by SensorManager.getSensorsList nor
  /// SensorManager.getDefaultSensor if the application doesn't have this permission
  heartRate,

  /// A sensor of this type generates an event each time a tilt event is detected.
  /// A tilt event is generated if the direction of the 2-seconds window average
  /// gravity changed by at least 35 degrees since the activation of the sensor.
  /// It is a wake up sensor.
  tiltDetector,

  /// A constant describing a wake gesture sensor.
  /// Wake gesture sensors enable waking up the device based on a device specific motion.
  /// When this sensor triggers, the device behaves as if the power button was
  /// pressed, turning the screen on. This behavior (turning on the screen when
  /// this sensor triggers) might be deactivated by the user in the device settings.
  /// Changes in settings do not impact the behavior of the sensor: only whether the framework turns the screen on when it triggers.
  /// The actual gesture to be detected is not specified, and can be chosen by
  /// the manufacturer of the device. This sensor must be low power, as it is
  /// likely to be activated 24/7. Values of events created by this sensors
  /// should not be used.
  wakeGesture,

  /// A constant describing a wake gesture sensor.
  /// A sensor enabling briefly turning the screen on to enable the user to
  /// glance content on screen based on a specific motion.
  /// The device should turn the screen off after a few moments.
  /// When this sensor triggers, the device turns the screen on momentarily to
  /// allow the user to glance notifications or other content while the device
  /// remains locked in a non-interactive state (dozing).
  /// This behavior (briefly turning on the screen when this sensor triggers)
  /// might be deactivated by the user in the device settings. Changes in
  /// settings do not impact the behavior of the sensor: only whether the
  /// framework briefly turns the screen on when it triggers.
  /// The actual gesture to be detected is not specified, and can be chosen by
  /// the manufacturer of the device. This sensor must be low power, as it is
  /// likely to be activated 24/7.
  /// Values of events created by this sensors should not be used.
  glanceGesture,

  /// A constant describing a pick up sensor.
  /// A sensor of this type triggers when the device is picked up regardless of
  /// wherever it was before (desk, pocket, bag).
  /// The only allowed return value is 1.0. This sensor deactivates itself
  /// immediately after it triggers.
  pickUpGesture,

  /// A constant describing a wrist tilt gesture sensor.
  /// A sensor of this type triggers when the device face is tilted towards the
  /// user.
  /// The only allowed return value is 1.0.
  /// This sensor remains active until disabled.
  wristTiltGesture,

  /// The current orientation of the device
  deviceOrientation,

  /// A constant describing a pose sensor with 6 degrees of freedom.
  /// Similar to [rotationVector], with additional delta translation from an
  /// arbitrary reference point.
  /// See SensorEvent.values for more details.
  /// Can use camera, depth sensor etc to compute output value.
  /// This is expected to be a high power sensor and expected only to be used
  /// when the screen is on.
  /// Expected to be more accurate than the rotation vector alone
  pose6DOF,

  /// A constant describing a stationary detect sensor
  stationaryDetect,

  /// Library may be not up to date to handle this unknown type.
  /// Fallback to manual handling of underlying type value.
  unknown,
}
