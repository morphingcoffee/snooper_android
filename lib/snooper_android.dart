import 'dart:async';

import 'package:flutter/services.dart';
import 'package:snooper_android/model/simple_android_package_info.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

class SnooperAndroid {
  static const MethodChannel _channel =
      MethodChannel('com.morphingcoffee.snooper_android');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Compute of [detailedPackageInfos] can be lengthy (longer than a single frame
  /// refresh period)
  static Future<List<SimpleAndroidPackageInfo>> get simplePackageInfos async {
    return _simplePackages();
  }

  /// Compute of [detailedPackageInfos] can be lengthy (much longer than a single frame
  /// refresh period)
  static Future<List<DetailedAndroidPackageInfo>>
      get detailedPackageInfos async {
    return _detailedPackages();
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
}
