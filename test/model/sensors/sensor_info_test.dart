import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/sensors/sensor_info.dart';

import '../../shared_dummy_data/sensors.dart';

void main() {
  tearDown(() {});

  test('sensorInfo_shouldRemainIndentical_onToMapFromMap', () async {
    final sensor = dummySensorWithAllFields();
    final otherSensor = SensorInfo.fromMap(sensor.toMap());
    expect(otherSensor, sensor);
  });

  test('sensorInfo_shouldRemainIndentical_onCopy', () async {
    final sensor = dummySensorWithAllFields();
    final copy = sensor.copyWith();
    expect(copy, sensor);
  });
}
