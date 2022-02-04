import 'dart:async';

import 'package:flutter/services.dart';
import 'package:snooper_android/model/audio/microphone_info.dart';
import 'package:snooper_android/model/features/system_feature.dart';
import 'package:snooper_android/model/sensors/sensor_info.dart';
import 'package:snooper_android/model/simple_android_package_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

class SnooperAndroid {
  static const MethodChannel _channel =
      MethodChannel('com.morphingcoffee.snooper_android');

  /// Get a list of all applications on the device along with most basic metadata
  ///
  /// Compute of [simplePackageInfos] can be lengthy (longer than a single frame
  /// refresh period)
  static Future<List<SimpleAndroidPackageInfo>> get simplePackageInfos async {
    return _simplePackages();
  }

  /// Get a list of all applications on the device along with detailed metadata
  ///
  /// Compute of [detailedPackageInfos] can be lengthy (much longer than a single frame
  /// refresh period)
  static Future<List<DetailedAndroidPackageInfo>>
      get detailedPackageInfos async {
    return _detailedPackages();
  }

  /// Get a list of device sensors along with their metadata
  ///
  /// Compute of [sensorInfos] can be lengthy (longer than a single frame
  /// refresh period)
  static Future<List<SensorInfo>> get sensorInfos async {
    return _sensors();
  }

  /// Get a list of hardware and software features of an Android device
  static Future<List<SystemFeature>> get systemFeatures async {
    return _systemFeatures();
  }

  /// Get a list of currently available built-in & connected
  /// (e.g. USB, Bluetooth) microphone metadata
  static Future<List<MicrophoneInfo>> get microphones async {
    return _microphones();
  }

  static Future<List<SimpleAndroidPackageInfo>> _simplePackages() async {
    final task =
        _channel.invokeListMethod<Map<dynamic, dynamic>>('getPackagesSimple');
    final taskResult = (await task) ?? [];
    final packageInfoMaps = taskResult.map((e) => Map<String, dynamic>.from(e));

    return packageInfoMaps
        .map((packageInfoMap) =>
            SimpleAndroidPackageInfo.fromMap(packageInfoMap))
        .toList(growable: false);
  }

  static Future<List<DetailedAndroidPackageInfo>> _detailedPackages() async {
    final task =
        _channel.invokeListMethod<Map<dynamic, dynamic>>('getPackagesDetailed');
    final taskResult = (await task) ?? [];
    final packageInfoMaps = taskResult.map((e) => Map<String, dynamic>.from(e));

    return packageInfoMaps
        .map((packageInfoMap) =>
            DetailedAndroidPackageInfo.fromMap(packageInfoMap))
        .toList(growable: false);
  }

  static Future<List<SensorInfo>> _sensors() async {
    final task = _channel.invokeListMethod<Map<dynamic, dynamic>>('getSensors');
    final taskResult = (await task) ?? [];
    final sensorInfoMaps = taskResult.map((e) => Map<String, dynamic>.from(e));

    return sensorInfoMaps
        .map((sensorInfoMap) => SensorInfo.fromMap(sensorInfoMap))
        .toList(growable: false);
  }

  static Future<List<SystemFeature>> _systemFeatures() async {
    final task =
        _channel.invokeListMethod<Map<dynamic, dynamic>>('getSystemFeatures');
    final taskResult = (await task) ?? [];
    final featureMaps = taskResult.map((e) => Map<String, dynamic>.from(e));

    return featureMaps
        .map((featureMap) => SystemFeature.fromMap(featureMap))
        .toList(growable: false);
  }

  static Future<List<MicrophoneInfo>> _microphones() async {
    final task =
        _channel.invokeListMethod<Map<dynamic, dynamic>>('getMicrophones');
    final taskResult = (await task) ?? [];
    final microphoneMaps = taskResult.map((e) => Map<String, dynamic>.from(e));

    return microphoneMaps
        .map((micMap) => MicrophoneInfo.fromMap(micMap))
        .toList(growable: false);
  }
}
