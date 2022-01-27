import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/android_service_info.dart';

import '../shared_dummy_data/services.dart';

void main() {
  tearDown(() {});

  test('androidService_shouldRemainIndentical_onToMapFromMap', () async {
    final service = dummyServiceWithAllFields();
    final otherService = AndroidServiceInfo.fromMap(service.toMap());
    expect(otherService, service);
  });

  test('androidService_shouldRemainIndentical_onCopy', () async {
    final service = dummyServiceWithAllFields();
    final copy = service.copyWith();
    expect(copy, service);
  });
}
