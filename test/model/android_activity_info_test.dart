import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/android_activity_info.dart';

import '../shared_dummy_data/activities.dart';

void main() {
  tearDown(() {});

  test('androidActivity_shouldRemainIndentical_onToMapFromMap', () async {
    final activity = dummyActivityWithAllFields();
    final otherActivity = AndroidActivityInfo.fromMap(activity.toMap());
    expect(otherActivity, activity);
  });

  test('androidActivity_shouldRemainIndentical_onCopy', () async {
    final activity = dummyActivityWithAllFields();
    final copy = activity.copyWith();
    expect(copy, activity);
  });
}
