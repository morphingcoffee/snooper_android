/// Definition of a single optional hardware
/// or software feature of an Android device.
///
/// More at:
/// https://developer.android.com/reference/android/content/pm/FeatureInfo
class SystemFeature {
  /// The name of this feature, for example "android.hardware.camera".
  /// If this is null, then this is an OpenGL ES version feature as described
  /// in reqGlEsVersion.
  final String? name;

  /// Additional flags.
  ///
  /// More at:
  /// https://developer.android.com/reference/android/content/pm/FeatureInfo#flags
  final int flags;

  /// Major and minor version of [reqGLEsVersion] attribute as a string.
  ///
  /// For example, reqGlEsVersion value of 0x00010002 is returned as 1.2
  final String? glEsVersion;

  /// The GLES version used by an application.
  /// The upper order 16 bits represent the major version and the lower
  /// order 16 bits the minor version. Only valid if name is null.
  final int? reqGlEsVersion;

  // region API >= 24

  /// If this object represents a feature supported by a device, this is the
  /// maximum version of this feature supported by the device.
  /// The device implicitly supports all older versions of this feature.
  ///
  /// If this object represents a feature requested by an app, this is the
  /// minimum version of the feature required by the app.
  /// When a feature version is undefined by a device, it's assumed
  /// to be version 0.
  final int? version;

  // endregion

  /// [SystemFeature] must have either [name] or
  /// [glEsVersion] & [reqGlEsVersion], but never both.
  const SystemFeature({
    this.name,
    required this.version,
    required this.flags,
    this.glEsVersion,
    this.reqGlEsVersion,
  }) : assert((name == null) ^ (glEsVersion == null && reqGlEsVersion == null));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemFeature &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          version == other.version &&
          flags == other.flags &&
          glEsVersion == other.glEsVersion &&
          reqGlEsVersion == other.reqGlEsVersion);

  @override
  int get hashCode =>
      name.hashCode ^
      version.hashCode ^
      flags.hashCode ^
      glEsVersion.hashCode ^
      reqGlEsVersion.hashCode;

  @override
  String toString() {
    return 'SystemFeature{'
        ' name: $name,'
        ' version: $version,'
        ' flags: $flags,'
        ' glEsVersion: $glEsVersion,'
        ' reqGlEsVersion: $reqGlEsVersion,'
        '}';
  }

  SystemFeature copyWith({
    String? name,
    int? version,
    int? flags,
    String? glEsVersion,
    int? reqGlEsVersion,
  }) {
    return SystemFeature(
      name: name ?? this.name,
      version: version ?? this.version,
      flags: flags ?? this.flags,
      glEsVersion: glEsVersion ?? this.glEsVersion,
      reqGlEsVersion: reqGlEsVersion ?? this.reqGlEsVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'flags': flags,
      'glEsVersion': glEsVersion,
      'reqGlEsVersion': reqGlEsVersion,
    };
  }

  factory SystemFeature.fromMap(Map<String, dynamic> map) {
    return SystemFeature(
      name: map['name'] as String?,
      version: map['version'] as int?,
      flags: map['flags'] as int,
      glEsVersion: map['glEsVersion'] as String?,
      reqGlEsVersion: map['reqGlEsVersion'] as int?,
    );
  }
}
