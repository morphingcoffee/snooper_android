import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/constants/android_flags.dart';
import 'package:snooper_android/model/info_flags.dart';

void main() {
  tearDown(() {});

  test('infoFlags_shouldHave_onlyEnabledFlags', () async {
    const flags = InfoFlags(
        value: ApplicationFlags.allowBackup |
            ApplicationFlags.usesCleartextTraffic);
    expect(flags.has(ApplicationFlags.allowBackup), true);
    expect(flags.has(ApplicationFlags.usesCleartextTraffic), true);
    expect(flags.has(ApplicationFlags.system), false);
  });

  test('infoFlags_underlyingValue_shouldMatch_sumOfComposites', () async {
    const flags = InfoFlags(
        value: ApplicationFlags.allowBackup |
            ApplicationFlags.usesCleartextTraffic);
    const sumOfCompositeFlags =
        ApplicationFlags.allowBackup + ApplicationFlags.usesCleartextTraffic;

    expect(flags.value, sumOfCompositeFlags);
  });
}
