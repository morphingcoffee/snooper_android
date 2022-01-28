import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/simple_android_package_info.dart';

import '../shared_dummy_data/packages.dart';

void main() {
  tearDown(() {});

  test('simpleAndroidPackageInfo_shouldRemainIndentical_onToMapFromMap',
      () async {
    final pkg = dummySimplePackageWithAllFields();
    final otherPkg = SimpleAndroidPackageInfo.fromMap(pkg.toMap());
    expect(otherPkg, pkg);
  });

  test('simpleAndroidPackageInfo_shouldRemainIndentical_onCopy', () async {
    final pkg = dummySimplePackageWithAllFields();
    final copy = pkg.copyWith();
    expect(copy, pkg);
  });
}
