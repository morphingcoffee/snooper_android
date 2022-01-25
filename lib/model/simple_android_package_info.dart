class SimpleAndroidPackageInfo {
  /// Return the label to use for this application
  final String name;

  /// Name of the package that this item is in
  final String? packageName;

  /// The kernel user-ID that has been assigned to this application;
  /// currently this is not a unique ID (multiple applications can have the same uid)
  final int uid;

  const SimpleAndroidPackageInfo({
    required this.name,
    this.packageName,
    required this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SimpleAndroidPackageInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          packageName == other.packageName &&
          uid == other.uid);

  @override
  int get hashCode => name.hashCode ^ packageName.hashCode ^ uid.hashCode;

  @override
  String toString() {
    return 'SimpleAndroidPackageInfo{'
        ' name: $name,'
        ' packageName: $packageName,'
        ' uid: $uid,'
        '}';
  }

  SimpleAndroidPackageInfo copyWith({
    String? name,
    String? packageName,
    int? uid,
  }) {
    return SimpleAndroidPackageInfo(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'packageName': packageName,
      'uid': uid,
    };
  }

  factory SimpleAndroidPackageInfo.fromMap(Map<String, dynamic> map) {
    return SimpleAndroidPackageInfo(
      name: map['name'] as String,
      packageName: map['packageName'] as String?,
      uid: map['uid'] as int,
    );
  }
}
