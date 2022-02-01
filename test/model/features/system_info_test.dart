import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/features/system_feature.dart';

import '../../shared_dummy_data/system_features.dart';

void main() {
  tearDown(() {});

  test('regularSystemFeature_shouldRemainIndentical_onToMapFromMap', () async {
    final feature = dummyNonGLESSystemFeature();
    final otherFeature = SystemFeature.fromMap(feature.toMap());
    expect(otherFeature, feature);
  });

  test('glesSystemFeature_shouldRemainIndentical_onToMapFromMap', () async {
    final feature = dummyGLESSystemFeature();
    final otherFeature = SystemFeature.fromMap(feature.toMap());
    expect(otherFeature, feature);
  });

  test('regularSystemFeature_shouldRemainIndentical_onCopy', () async {
    final feature = dummyNonGLESSystemFeature();
    final copy = feature.copyWith();
    expect(copy, feature);
  });

  test('glesSystemFeature_shouldRemainIndentical_onCopy', () async {
    final feature = dummyGLESSystemFeature();
    final copy = feature.copyWith();
    expect(copy, feature);
  });
}
