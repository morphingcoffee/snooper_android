import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/constants/sensor_types.dart';
import 'package:snooper_android/model/sensors/sensor_type_wrapper.dart';

void main() {
  final Map<int, SensorType> expectedTypeMappings = {
    1: SensorType.accelerometer,
    2: SensorType.magneticField,
    3: SensorType.orientation,
    4: SensorType.gyroscope,
    5: SensorType.light,
    6: SensorType.pressure,
    7: SensorType.temperature,
    8: SensorType.proximity,
    9: SensorType.gravity,
    10: SensorType.linearAcceleration,
    11: SensorType.rotationVector,
    12: SensorType.relativeHumidity,
    13: SensorType.ambientTemperature,
    14: SensorType.magneticFieldUncalibrated,
    15: SensorType.gameRotationVector,
    16: SensorType.gyroscopeUncalibrated,
    17: SensorType.significantMotion,
    18: SensorType.stepDetector,
    19: SensorType.stepCounter,
    20: SensorType.geomagneticRotationVector,
    21: SensorType.heartRate,
    22: SensorType.tiltDetector,
    23: SensorType.wakeGesture,
    24: SensorType.glanceGesture,
    25: SensorType.pickUpGesture,
    26: SensorType.wristTiltGesture,
    27: SensorType.deviceOrientation,
    28: SensorType.pose6DOF,
    29: SensorType.stationaryDetect,
    30: SensorType.motionDetect,
    31: SensorType.heartBeat,
    32: SensorType.dynamicSensorMeta,

    /// type 33 is not exposed to apps
    33: SensorType.unknown,
    34: SensorType.lowLatencyOffbodyDetect,
    35: SensorType.accelerometerUncalibrated,
    36: SensorType.hingeAngle,
  };

  tearDown(() {});

  test('sensorTypeWrapper_shouldMapTypeValues_toCorrectEnums', () async {
    expectedTypeMappings.forEach((sensorTypeValue, expectedSensor) {
      final sensorTypeWrapper = SensorTypeWrapper(typeValue: sensorTypeValue);
      expect(sensorTypeWrapper.sensorType, expectedSensor);
    });
  });
}
