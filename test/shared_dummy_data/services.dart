import 'package:snooper_android/model/android_service_info.dart';

AndroidServiceInfo dummyServiceWithAllFields() {
  return const AndroidServiceInfo(
    name: 'name',
    flags: 1,
    exported: true,
    enabled: true,
  );
}
