import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/info_flags.dart';
import 'package:snooper_android/snooper_android.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('com.morphingcoffee.snooper_android');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  Map<String, dynamic> _packageMapWithMissingFields() {
    return {
      'name': '1',
      'packageName': null,
      'uid': 3,
      'iconBytes': null,
      'description': null,
      'processName': null,
      'dataDir': null,
      'backupAgentName': null,
      'nativeLibraryDir': null,
      'taskAffinity': null,
      'className': null,
      'permission': null,
      'publicSourceDir': null,
      'enabled': false,
      'sharedLibraryFiles': null,
      'flags': 4,
      'firstInstallTime': 5,
      'lastUpdateTime': 6,
      'services': null,
      'activities': null,
      'minSdkVersion': 7,
      'deviceProtectedDataDir': null,
      'storageUuid': null,
      'splitNames': null,
      'signatures': null,
      'installInitiatingPackageName': null,
    };
  }

  test('detailedPackageInfos_returnEmptyList_whenPackagesEmpty', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesdetailed') {
        return [];
      }
    });

    expect(await SnooperAndroid.detailedPackageInfos, []);
  });

  test('detailedPackageInfos_returnEmptyList_whenPackagesNull', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesDetailed') {
        return null;
      }
    });

    expect(await SnooperAndroid.detailedPackageInfos, []);
  });

  test('detailedPackageInfos_returnData_whenPackagesHaveMissingFields',
      () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPackagesDetailed') {
        return [_packageMapWithMissingFields()];
      }
    });

    final actualPkgs = await SnooperAndroid.detailedPackageInfos;
    expect(actualPkgs.length, 1);
    final actualPkg = actualPkgs[0];
    expect(actualPkg.name, '1');
    expect(actualPkg.packageName, null);
    expect(actualPkg.uid, 3);
    expect(actualPkg.iconBytes, null);
    expect(actualPkg.description, null);
    expect(actualPkg.processName, null);
    expect(actualPkg.dataDir, null);
    expect(actualPkg.backupAgentName, null);
    expect(actualPkg.nativeLibraryDir, null);
    expect(actualPkg.taskAffinity, null);
    expect(actualPkg.className, null);
    expect(actualPkg.permission, null);
    expect(actualPkg.publicSourceDir, null);
    expect(actualPkg.enabled, false);
    expect(actualPkg.sharedLibraryFiles, null);
    expect(actualPkg.flags, const InfoFlags(value: 4));
    expect(actualPkg.firstInstallTime, 5);
    expect(actualPkg.lastUpdateTime, 6);
    expect(actualPkg.services, null);
    expect(actualPkg.activities, null);
    expect(actualPkg.minSdkVersion, 7);
    expect(actualPkg.deviceProtectedDataDir, null);
    expect(actualPkg.storageUuid, null);
    expect(actualPkg.splitNames, null);
    expect(actualPkg.installInitiatingPackageName, null);
  });
}
