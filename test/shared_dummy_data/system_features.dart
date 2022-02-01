import 'package:snooper_android/model/features/system_feature.dart';

/// Non-GlEs must have a `name` field
SystemFeature dummyNonGLESSystemFeature() {
  return const SystemFeature(
    name: "non-GLES-feature",
    version: 123,
    flags: 12345,
    reqGlEsVersion: null,
    glEsVersion: null,
  );
}

/// GlEs must have no `name` field
SystemFeature dummyGLESSystemFeature() {
  return const SystemFeature(
    name: null,
    version: 123,
    flags: 12345,
    reqGlEsVersion: 0x00010002,
    glEsVersion: "1.2",
  );
}
