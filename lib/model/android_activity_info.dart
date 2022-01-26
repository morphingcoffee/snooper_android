class AndroidActivityInfo {
  /// Public name of this activity. From the "android:name" attribute
  final String? name;

  /// Options that have been set in the activity declaration in the manifest
  final int flags;

  /// Set to true if this component is available for use by other applications
  final bool exported;

  /// Indicates whether or not this component may be instantiated.
  /// Note that this value can be overridden by the one in its parent
  final bool enabled;

  /// If this is an activity alias, this is the real activity class to run for it.
  /// Otherwise, this is null.
  final String? targetActivity;

  /// If defined, the activity named here is the logical parent of this activity
  final String? parentActivityName;

  /// The preferred screen orientation this activity would like to run in
  /// https://developer.android.com/reference/android/R.attr#screenOrientation
  final int screenOrientation;

  /// The affinity this activity has for another task in the system.
  /// The string here is the name of the task, often the package name of the
  /// overall package. If null, the activity has no affinity.
  final String? taskAffinity;

  /// The launch mode style requested by the activity
  /// https://developer.android.com/reference/android/R.attr#launchMode
  final int launchMode;

  const AndroidActivityInfo({
    this.name,
    required this.flags,
    required this.exported,
    required this.enabled,
    this.targetActivity,
    this.parentActivityName,
    required this.screenOrientation,
    this.taskAffinity,
    required this.launchMode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AndroidActivityInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          flags == other.flags &&
          exported == other.exported &&
          enabled == other.enabled &&
          targetActivity == other.targetActivity &&
          parentActivityName == other.parentActivityName &&
          screenOrientation == other.screenOrientation &&
          taskAffinity == other.taskAffinity &&
          launchMode == other.launchMode);

  @override
  int get hashCode =>
      name.hashCode ^
      flags.hashCode ^
      exported.hashCode ^
      enabled.hashCode ^
      targetActivity.hashCode ^
      parentActivityName.hashCode ^
      screenOrientation.hashCode ^
      taskAffinity.hashCode ^
      launchMode.hashCode;

  @override
  String toString() {
    return 'AndroidActivityInfo{' +
        ' name: $name,' +
        ' flags: $flags,' +
        ' exported: $exported,' +
        ' enabled: $enabled,' +
        ' targetActivity: $targetActivity,' +
        ' parentActivityName: $parentActivityName,' +
        ' screenOrientation: $screenOrientation,' +
        ' taskAffinity: $taskAffinity,' +
        ' launchMode: $launchMode,' +
        '}';
  }

  AndroidActivityInfo copyWith({
    String? name,
    int? flags,
    bool? exported,
    bool? enabled,
    String? targetActivity,
    String? parentActivityName,
    int? screenOrientation,
    String? taskAffinity,
    int? launchMode,
  }) {
    return AndroidActivityInfo(
      name: name ?? this.name,
      flags: flags ?? this.flags,
      exported: exported ?? this.exported,
      enabled: enabled ?? this.enabled,
      targetActivity: targetActivity ?? this.targetActivity,
      parentActivityName: parentActivityName ?? this.parentActivityName,
      screenOrientation: screenOrientation ?? this.screenOrientation,
      taskAffinity: taskAffinity ?? this.taskAffinity,
      launchMode: launchMode ?? this.launchMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'flags': flags,
      'exported': exported,
      'enabled': enabled,
      'targetActivity': targetActivity,
      'parentActivityName': parentActivityName,
      'screenOrientation': screenOrientation,
      'taskAffinity': taskAffinity,
      'launchMode': launchMode,
    };
  }

  factory AndroidActivityInfo.fromMap(Map<String, dynamic> map) {
    return AndroidActivityInfo(
      name: map['name'] as String?,
      flags: map['flags'] as int,
      exported: map['exported'] as bool,
      enabled: map['enabled'] as bool,
      targetActivity: map['targetActivity'] as String?,
      parentActivityName: map['parentActivityName'] as String?,
      screenOrientation: map['screenOrientation'] as int,
      taskAffinity: map['taskAffinity'] as String?,
      launchMode: map['launchMode'] as int,
    );
  }

}
