import 'package:snooper_android/model/sensors/sensor_info.dart';
import 'package:snooper_android/model/sensors/sensor_type_wrapper.dart';

SensorInfo dummySensorWithAllFields() {
  return const SensorInfo(
    name: "sensorName",
    stringType: 'stringType',
    vendor: 'vendor',
    // type 1 ≡ accelerometer
    type: SensorTypeWrapper(typeValue: 1),
    isWakeUpSensor: true,
    reportingMode: 1,
    version: 2,
    maximumRange: 3,
    resolution: 4,
    maxDelay: 5,
    minDelay: 6,
    power: 7,
    isDynamicSensor: true,
    isAdditionalInfoSupported: true,
    highestDirectReportRateLevel: 8,
  );
}

SensorInfo dummySensorWithMissingFields() {
  return const SensorInfo(
    name: null,
    stringType: null,
    vendor: null,
    // type 1 ≡ accelerometer
    type: SensorTypeWrapper(typeValue: 1),
    isWakeUpSensor: true,
    reportingMode: 1,
    version: 2,
    maximumRange: 3,
    resolution: 4,
    maxDelay: 5,
    minDelay: 6,
    power: 7,
    isDynamicSensor: true,
    isAdditionalInfoSupported: true,
    highestDirectReportRateLevel: 8,
  );
}
