import 'dart:typed_data';
import 'package:snooper_android/model/detailed_android_package_info.dart';
import 'package:snooper_android/model/info_flags.dart';
import 'package:snooper_android/model/simple_android_package_info.dart';

import 'activities.dart';
import 'services.dart';
import 'signatures.dart';

SimpleAndroidPackageInfo dummySimplePackageWithAllFields() {
  return const SimpleAndroidPackageInfo(
    name: 'name',
    packageName: 'packageName',
    uid: 3,
  );
}

DetailedAndroidPackageInfo dummyDetailedPackageWithAllFields() {
  return DetailedAndroidPackageInfo(
    name: 'name',
    packageName: 'packageName',
    uid: 3,
    iconBytes: Uint8List.fromList('iconBytes'.codeUnits),
    description: 'description',
    processName: 'processName',
    dataDir: 'dataDir',
    backupAgentName: 'backupAgentName',
    nativeLibraryDir: 'nativeLibraryDir',
    taskAffinity: 'taskAffinity',
    className: 'className',
    permission: 'permission',
    publicSourceDir: 'publicSourceDir',
    enabled: false,
    sharedLibraryFiles: ['shared', 'library', 'files'],
    flags: const InfoFlags(value: 4),
    firstInstallTime: 5,
    lastUpdateTime: 6,
    services: [dummyServiceWithAllFields()],
    activities: [dummyActivityWithAllFields()],
    minSdkVersion: 7,
    deviceProtectedDataDir: 'deviceProtectedDataDir',
    storageUuid: 'storageUuid',
    splitNames: ['split', 'names'],
    signatures: [dummySignatureWithAllFields()],
    installInitiatingPackageName: 'installInitiatingPackageName',
  );
}
