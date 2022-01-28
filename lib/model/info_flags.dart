import 'package:snooper_android/constants/android_flags.dart';

/// Class to store underlying flags [value] and check whether it [has]
/// [ApplicationFlags] or any arbitrary int flags
class InfoFlags {
  final int value;

  const InfoFlags({
    required this.value,
  });

  /// [value] can contain multiple flags.
  /// Perform a bitwise AND with a specific [ApplicationFlags]
  /// value to check if it's enabled.
  bool has(int flag) {
    return (value & flag) == flag;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InfoFlags &&
          runtimeType == other.runtimeType &&
          value == other.value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'InfoFlags{' ' value: $value,' '}';
  }
}
