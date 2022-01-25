import 'dart:typed_data';

class DetailedAndroidPackageInfo {
  /// Return the label to use for this application
  final String name;

  /// Name of the package that this item is in
  final String? packageName;

  /// The kernel user-ID that has been assigned to this application;
  /// currently this is not a unique ID (multiple applications can have the same uid)
  final int uid;

  /// App icon byte array
  final Uint8List? iconBytes;

  /// The textual description of the application
  final String? description;

  /// The name of the process this application should run in.
  /// From the "process" attribute or, if not set, the same as [packageName]
  final String? processName;

  /// Full path to the default directory assigned to the package for its persistent data.
  final String? dataDir;

  /// Class implementing the Application's backup functionality
  final String? backupAgentName;

  /// Full path to the directory where native JNI libraries are stored
  final String? nativeLibraryDir;

  /// Default task affinity of all activities in this application
  final String? taskAffinity;

  /// Class implementing the Application object. From the "class" attribute
  final String? className;

  /// Optional name of a permission required to be able to access this
  /// application's components. From the "permission" attribute
  final String? permission;

  /// Full path to the publicly available parts of sourceDir, including resources
  /// and manifest. This may be different from sourceDir if an application is
  /// forward locked.
  final String? publicSourceDir;

  /// When false, indicates that all components within this application are
  /// considered disabled, regardless of their individually set enabled status
  final bool enabled;

  /// Paths to all shared libraries this application is linked against.
  final List<String>? sharedLibraryFiles;

  /// Flags associated with the application
  final int flags;

  /// The time at which the app was first installed.
  /// Units are as per System.currentTimeMillis()
  final int firstInstallTime;

  /// The time at which the app was last updated.
  /// Units are as per System.currentTimeMillis()
  final int lastUpdateTime;

  // region API >= 24

  /// The minimum SDK version this application can run on.
  /// It will not run on earlier versions.
  final int minSdkVersion;

  /// Full path to the device-protected directory assigned to the package for
  /// its persistent data.
  final String? deviceProtectedDataDir;

  // endregion

  // region API >= 26

  /// UUID of the storage volume on which this application is being hosted
  final String? storageUuid;

  /// The names of all installed split APKs, ordered lexicographically
  final List<String>? splitNames;

  // endregion

  // region API >= 28

  /// The names of all installed split APKs, ordered lexicographically
  final List<Map<String, dynamic>>? apkSigningCertificates;

  // endregion

  // region API >= 30

  /// The name of the package that requested the installation, or null if not
  /// available. This is normally the same as the installing package name
  final String? installInitiatingPackageName;

  const DetailedAndroidPackageInfo({
    required this.name,
    this.packageName,
    required this.uid,
    this.iconBytes,
    this.description,
    this.processName,
    this.dataDir,
    this.backupAgentName,
    this.nativeLibraryDir,
    this.taskAffinity,
    this.className,
    this.permission,
    this.publicSourceDir,
    required this.enabled,
    this.sharedLibraryFiles,
    required this.flags,
    required this.firstInstallTime,
    required this.lastUpdateTime,
    required this.minSdkVersion,
    this.deviceProtectedDataDir,
    this.storageUuid,
    this.splitNames,
    this.apkSigningCertificates,
    this.installInitiatingPackageName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailedAndroidPackageInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          packageName == other.packageName &&
          uid == other.uid &&
          iconBytes == other.iconBytes &&
          description == other.description &&
          processName == other.processName &&
          dataDir == other.dataDir &&
          backupAgentName == other.backupAgentName &&
          nativeLibraryDir == other.nativeLibraryDir &&
          taskAffinity == other.taskAffinity &&
          className == other.className &&
          permission == other.permission &&
          publicSourceDir == other.publicSourceDir &&
          enabled == other.enabled &&
          sharedLibraryFiles == other.sharedLibraryFiles &&
          flags == other.flags &&
          firstInstallTime == other.firstInstallTime &&
          lastUpdateTime == other.lastUpdateTime &&
          minSdkVersion == other.minSdkVersion &&
          deviceProtectedDataDir == other.deviceProtectedDataDir &&
          storageUuid == other.storageUuid &&
          splitNames == other.splitNames &&
          apkSigningCertificates == other.apkSigningCertificates &&
          installInitiatingPackageName == other.installInitiatingPackageName);

  @override
  int get hashCode =>
      name.hashCode ^
      packageName.hashCode ^
      uid.hashCode ^
      iconBytes.hashCode ^
      description.hashCode ^
      processName.hashCode ^
      dataDir.hashCode ^
      backupAgentName.hashCode ^
      nativeLibraryDir.hashCode ^
      taskAffinity.hashCode ^
      className.hashCode ^
      permission.hashCode ^
      publicSourceDir.hashCode ^
      enabled.hashCode ^
      sharedLibraryFiles.hashCode ^
      flags.hashCode ^
      firstInstallTime.hashCode ^
      lastUpdateTime.hashCode ^
      minSdkVersion.hashCode ^
      deviceProtectedDataDir.hashCode ^
      storageUuid.hashCode ^
      splitNames.hashCode ^
      apkSigningCertificates.hashCode ^
      installInitiatingPackageName.hashCode;

  @override
  String toString() {
    return 'DetailedAndroidPackageInfo{'
        ' name: $name,'
        ' packageName: $packageName,'
        ' uid: $uid,'
        ' iconBytes.hashCode: ${iconBytes.hashCode},'
        ' description: $description,'
        ' processName: $processName,'
        ' dataDir: $dataDir,'
        ' backupAgentName: $backupAgentName,'
        ' nativeLibraryDir: $nativeLibraryDir,'
        ' taskAffinity: $taskAffinity,'
        ' className: $className,'
        ' permission: $permission,'
        ' publicSourceDir: $publicSourceDir,'
        ' enabled: $enabled,'
        ' sharedLibraryFiles: $sharedLibraryFiles,'
        ' flags: $flags,'
        ' firstInstallTime: $firstInstallTime,'
        ' lastUpdateTime: $lastUpdateTime,'
        ' minSdkVersion: $minSdkVersion,'
        ' deviceProtectedDataDir: $deviceProtectedDataDir,'
        ' storageUuid: $storageUuid,'
        ' splitNames: $splitNames,'
        ' apkSigningCertificates: $apkSigningCertificates,'
        ' installInitiatingPackageName: $installInitiatingPackageName,'
        '}';
  }

  DetailedAndroidPackageInfo copyWith({
    String? name,
    String? packageName,
    int? uid,
    Uint8List? iconBytes,
    String? description,
    String? processName,
    String? dataDir,
    String? backupAgentName,
    String? nativeLibraryDir,
    String? taskAffinity,
    String? className,
    String? permission,
    String? publicSourceDir,
    bool? enabled,
    List<String>? sharedLibraryFiles,
    int? flags,
    int? firstInstallTime,
    int? lastUpdateTime,
    int? minSdkVersion,
    String? deviceProtectedDataDir,
    String? storageUuid,
    List<String>? splitNames,
    List<Map<String, dynamic>>? apkSigningCertificates,
    String? installInitiatingPackageName,
  }) {
    return DetailedAndroidPackageInfo(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      uid: uid ?? this.uid,
      iconBytes: iconBytes ?? this.iconBytes,
      description: description ?? this.description,
      processName: processName ?? this.processName,
      dataDir: dataDir ?? this.dataDir,
      backupAgentName: backupAgentName ?? this.backupAgentName,
      nativeLibraryDir: nativeLibraryDir ?? this.nativeLibraryDir,
      taskAffinity: taskAffinity ?? this.taskAffinity,
      className: className ?? this.className,
      permission: permission ?? this.permission,
      publicSourceDir: publicSourceDir ?? this.publicSourceDir,
      enabled: enabled ?? this.enabled,
      sharedLibraryFiles: sharedLibraryFiles ?? this.sharedLibraryFiles,
      flags: flags ?? this.flags,
      firstInstallTime: firstInstallTime ?? this.firstInstallTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      minSdkVersion: minSdkVersion ?? this.minSdkVersion,
      deviceProtectedDataDir:
          deviceProtectedDataDir ?? this.deviceProtectedDataDir,
      storageUuid: storageUuid ?? this.storageUuid,
      splitNames: splitNames ?? this.splitNames,
      apkSigningCertificates:
          apkSigningCertificates ?? this.apkSigningCertificates,
      installInitiatingPackageName:
          installInitiatingPackageName ?? this.installInitiatingPackageName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'packageName': packageName,
      'uid': uid,
      'iconBytes': iconBytes,
      'description': description,
      'processName': processName,
      'dataDir': dataDir,
      'backupAgentName': backupAgentName,
      'nativeLibraryDir': nativeLibraryDir,
      'taskAffinity': taskAffinity,
      'className': className,
      'permission': permission,
      'publicSourceDir': publicSourceDir,
      'enabled': enabled,
      'sharedLibraryFiles': sharedLibraryFiles,
      'flags': flags,
      'firstInstallTime': firstInstallTime,
      'lastUpdateTime': lastUpdateTime,
      'minSdkVersion': minSdkVersion,
      'deviceProtectedDataDir': deviceProtectedDataDir,
      'storageUuid': storageUuid,
      'splitNames': splitNames,
      'apkSigningCertificates': apkSigningCertificates,
      'installInitiatingPackageName': installInitiatingPackageName,
    };
  }

  factory DetailedAndroidPackageInfo.fromMap(Map<String, dynamic> map) {
    return DetailedAndroidPackageInfo(
      name: map['name'] as String,
      packageName: map['packageName'] as String?,
      uid: map['uid'] as int,
      iconBytes: map['iconBytes'] as Uint8List?,
      description: map['description'] as String?,
      processName: map['processName'] as String?,
      dataDir: map['dataDir'] as String?,
      backupAgentName: map['backupAgentName'] as String?,
      nativeLibraryDir: map['nativeLibraryDir'] as String?,
      taskAffinity: map['taskAffinity'] as String?,
      className: map['className'] as String?,
      permission: map['permission'] as String?,
      publicSourceDir: map['publicSourceDir'] as String?,
      enabled: map['enabled'] as bool,
      sharedLibraryFiles: map['sharedLibraryFiles'] == null
          ? null
          : List<String>.from(map['sharedLibraryFiles']),
      flags: map['flags'] as int,
      firstInstallTime: map['firstInstallTime'] as int,
      lastUpdateTime: map['lastUpdateTime'] as int,
      minSdkVersion: map['minSdkVersion'] as int,
      deviceProtectedDataDir: map['deviceProtectedDataDir'] as String?,
      storageUuid: map['storageUuid'] as String?,
      splitNames: map['splitNames'] == null
          ? null
          : List<String>.from(map['splitNames']),
      apkSigningCertificates: map['apkSigningCertificates'] == null
          ? null
          : List<Map<Object?, Object?>>.from(map['apkSigningCertificates'])
              .map((e) => Map<String, dynamic>.from(e))
              .toList(),
      installInitiatingPackageName:
          map['installInitiatingPackageName'] as String?,
    );
  }
}
