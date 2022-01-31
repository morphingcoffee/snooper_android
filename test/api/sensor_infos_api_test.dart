import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/snooper_android.dart';

import '../shared_dummy_data/sensors.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('com.morphingcoffee.snooper_android');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('sensorInfos_returnEmptyList_whenSensorsEmpty', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getSensors') {
        return [];
      }
    });

    expect(await SnooperAndroid.sensorInfos, []);
  });

  test('sensorInfos_returnEmptyList_whenSensorsNull', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getSensors') {
        return null;
      }
    });

    expect(await SnooperAndroid.sensorInfos, []);
  });

  test('sensorInfos_returnData_whenSensorsExist', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getSensors') {
        return [
          dummySensorWithAllFields().toMap(),
        ];
      }
    });

    final actualSensors = await SnooperAndroid.sensorInfos;
    expect(actualSensors.length, 1);
    final actualSensor = actualSensors[0];
    expect(actualSensor, dummySensorWithAllFields());
  });
}
