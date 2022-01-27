import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/detailed_android_package_info.dart';

import '../shared_dummy_data/packages.dart';

void main() {
  tearDown(() {});

  test('detailedAndroidPackageInfo_shouldRemainIndentical_onToMapFromMap',
      () async {
    final pkg = dummyDetailedPackageWithAllFields();
    final otherPkg = DetailedAndroidPackageInfo.fromMap(pkg.toMap());
    expect(otherPkg, pkg);
  });

  test('detailedAndroidPackageInfo_shouldRemainIndentical_onCopy', () async {
    final pkg = dummyDetailedPackageWithAllFields();
    final copy = pkg.shallowCopyWith();
    expect(copy, pkg);
  });
}
