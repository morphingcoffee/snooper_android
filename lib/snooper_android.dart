import 'dart:async';

import 'package:flutter/services.dart';

class SnooperAndroid {
  static const MethodChannel _channel = MethodChannel('snooper_android');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
