import 'package:snooper_android/constants/sensor_types.dart';

class SensorTypeWrapper {
  /// Generic type of this sensor.
  /// Full list available at:
  /// https://developer.android.com/reference/android/hardware/Sensor
  final int typeValue;

  const SensorTypeWrapper({
    required this.typeValue,
  });

  /// Returns a [SensorType] from known values.
  ///
  /// Future sensor types will yield [SensorType.unknown] value;
  /// [typeValue] can then be used directly for manual handling.
  SensorType get sensorType {
    switch (typeValue) {
      case (1):
        return SensorType.accelerometer;
      case (2):
        return SensorType.magneticField;
      case (3):
        return SensorType.orientation;
      case (4):
        return SensorType.gyroscope;
      case (5):
        return SensorType.light;
      case (6):
        return SensorType.pressure;
      case (7):
        return SensorType.temperature;
      case (8):
        return SensorType.proximity;
      case (9):
        return SensorType.gravity;
      case (10):
        return SensorType.linearAcceleration;
      case (11):
        return SensorType.rotationVector;
      case (12):
        return SensorType.relativeHumidity;
      case (13):
        return SensorType.ambientTemperature;
      case (14):
        return SensorType.magneticFieldUncalibrated;
      case (15):
        return SensorType.gameRotationVector;
      case (16):
        return SensorType.gyroscopeUncalibrated;
      case (17):
        return SensorType.significantMotion;
      case (18):
        return SensorType.stepDetector;
      case (19):
        return SensorType.stepCounter;
      case (20):
        return SensorType.geomagneticRotationVector;
      case (21):
        return SensorType.heartRate;
      case (22):
        return SensorType.tiltDetector;
      case (23):
        return SensorType.wakeGesture;
      case (24):
        return SensorType.glanceGesture;
      case (25):
        return SensorType.pickUpGesture;
      case (26):
        return SensorType.wristTiltGesture;
      case (27):
        return SensorType.deviceOrientation;
      case (28):
        return SensorType.pose6DOF;
      case (29):
        return SensorType.stationaryDetect;

      /// If [SensorType.unknown] is reached, library needs updating.
      /// Consumer should fall back to manual handling of [typeValue]
      /// for newly added sensor types
      default:
        return SensorType.unknown;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorTypeWrapper &&
          runtimeType == other.runtimeType &&
          typeValue == other.typeValue);

  @override
  int get hashCode => typeValue.hashCode;

  @override
  String toString() {
    return 'SensorType{' ' typeValue: $typeValue,' '}';
  }
}
