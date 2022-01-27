import 'package:snooper_android/model/android_activity_info.dart';

AndroidActivityInfo dummyActivityWithAllFields() {
  return const AndroidActivityInfo(
    name: 'name',
    flags: 1,
    exported: true,
    enabled: true,
    targetActivity: 'targetActivity',
    parentActivityName: 'parentActivityName',
    screenOrientation: 2,
    taskAffinity: 'taskAffinity',
    launchMode: 3,
  );
}
