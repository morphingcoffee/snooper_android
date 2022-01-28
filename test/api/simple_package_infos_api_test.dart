import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/snooper_android.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('com.morphingcoffee.snooper_android');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('simplePackageInfos_returnEmptyList_whenPackagesEmpty', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesSimple') {
        return [];
      }
    });

    expect(await SnooperAndroid.simplePackageInfos, []);
  });

  test('simplePackageInfos_returnEmptyList_whenPackagesNull', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesSimple') {
        return null;
      }
    });

    expect(await SnooperAndroid.simplePackageInfos, []);
  });

  test('simplePackageInfos_returnData_whenPackagesExist', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesSimple') {
        return [
          {
            'name': '1',
            'packageName': '2',
            'uid': 3,
          },
        ];
      }
    });

    final actualPkgs = await SnooperAndroid.simplePackageInfos;
    expect(actualPkgs.length, 1);
    final actualPkg = actualPkgs[0];
    expect(actualPkg.name, '1');
    expect(actualPkg.packageName, '2');
    expect(actualPkg.uid, 3);
  });
}
