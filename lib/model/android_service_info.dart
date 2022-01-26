class AndroidServiceInfo {
  /// Public name of this item. From the "android:name" attribute
  final String? name;

  /// Options that have been set in the service declaration in the manifest
  final int flags;

  /// Set to true if this component is available for use by other application
  final bool exported;

  /// Indicates whether or not this component may be instantiated.
  /// Note that this value can be overridden by the one in its parent
  final bool enabled;

  const AndroidServiceInfo({
    this.name,
    required this.flags,
    required this.exported,
    required this.enabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AndroidServiceInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          flags == other.flags &&
          exported == other.exported &&
          enabled == other.enabled);

  @override
  int get hashCode =>
      name.hashCode ^ flags.hashCode ^ exported.hashCode ^ enabled.hashCode;

  @override
  String toString() {
    return 'AndroidServiceInfo{'
        ' name: $name,'
        ' flags: $flags,'
        ' exported: $exported,'
        ' enabled: $enabled,'
        '}';
  }

  AndroidServiceInfo copyWith({
    String? name,
    int? flags,
    bool? exported,
    bool? enabled,
  }) {
    return AndroidServiceInfo(
      name: name ?? this.name,
      flags: flags ?? this.flags,
      exported: exported ?? this.exported,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'flags': flags,
      'exported': exported,
      'enabled': enabled,
    };
  }

  factory AndroidServiceInfo.fromMap(Map<String, dynamic> map) {
    return AndroidServiceInfo(
      name: map['name'] as String,
      flags: map['flags'] as int,
      exported: map['exported'] as bool,
      enabled: map['enabled'] as bool,
    );
  }
}
