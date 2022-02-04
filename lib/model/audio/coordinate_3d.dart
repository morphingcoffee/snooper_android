/// Data class encapsulating 3-dimensional coordinate data
/// as three double values x, y, & z
class Coordinate3D {
  /// X-Axis value
  final double x;

  /// Y-Axis value
  final double y;

  /// Z-Axis value
  final double z;

  const Coordinate3D({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coordinate3D &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          z == other.z);

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  @override
  String toString() {
    return 'Coordinate3D{' ' x: $x,' ' y: $y,' ' z: $z,' '}';
  }

  Coordinate3D copyWith({
    double? x,
    double? y,
    double? z,
  }) {
    return Coordinate3D(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }

  List<double> toList() {
    return [x, y, z];
  }

  factory Coordinate3D.fromMap(Map<String, dynamic> map) {
    return Coordinate3D(
      x: map['x'] as double,
      y: map['y'] as double,
      z: map['z'] as double,
    );
  }

  factory Coordinate3D.fromList(List<dynamic> list) {
    assert(list.length == 3,
        'Expecting a list containing 3 floating type values: [x, y, z]');
    return Coordinate3D(
      x: list[0] as double,
      y: list[1] as double,
      z: list[2] as double,
    );
  }
}
