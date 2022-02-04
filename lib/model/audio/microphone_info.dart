import 'package:snooper_android/model/audio/freq_response.dart';

import 'coordinate_3d.dart';

class MicrophoneInfo {
  /// Microphone's id
  final int id;

  /// The "address" string of the microphone
  final String address;

  /// Alphanumeric code that uniquely identifies the device.
  final String? description;

  /// A device group id that can be used to group together microphones on the
  /// same peripheral, attachments or logical groups.
  ///
  /// Main body is usually group 0.
  final int group;

  /// Directionality of microphone.
  ///
  /// More at:
  /// https://developer.android.com/reference/android/media/MicrophoneInfo#getDirectionality()
  final int directionality;

  /// The location of the microphone
  ///
  /// More at:
  /// https://developer.android.com/reference/android/media/MicrophoneInfo#getLocation()
  final int location;

  /// Returns the level in dBFS produced by a 1000Hz tone at 94 dB SPL.
  /// Null if unknown.
  final double? sensitivity;

  /// Returns the level in dB of the maximum SPL supported by the device at 1000Hz.
  /// Null if unknown.
  final double? maxSpl;

  /// Returns the level in dB of the minimum SPL that can be registered by the device at 1000Hz.
  /// Null if unknown.
  final double? minSpl;

  /// Returns a pair list of frequency responses; the first value represents
  /// frequency in Hz, and the second value represents response in dB.
  final List<FreqResponse>? frequencyResponse;

  /// Geometric location of microphone in meters.
  /// For mobile devices, the axes originate from the bottom-left-back corner of
  /// the appliance.
  /// In devices with FEATURE_AUTOMOTIVE, axes are defined with respect to the
  /// vehicle body frame, originating from the center of the vehicle's rear axle
  final Coordinate3D? position;

  /// Returns A [Coordinate3D] object that represents the orientation
  /// of microphone.
  /// The orientation is normalized such as sqrt(x^2 + y^2 + z^2) equals 1.
  final Coordinate3D? orientation;

  const MicrophoneInfo({
    required this.id,
    required this.address,
    this.description,
    required this.group,
    required this.directionality,
    required this.location,
    this.sensitivity,
    this.maxSpl,
    this.minSpl,
    this.frequencyResponse,
    this.position,
    this.orientation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MicrophoneInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          address == other.address &&
          description == other.description &&
          group == other.group &&
          directionality == other.directionality &&
          location == other.location &&
          sensitivity == other.sensitivity &&
          maxSpl == other.maxSpl &&
          minSpl == other.minSpl &&
          frequencyResponse == other.frequencyResponse &&
          position == other.position &&
          orientation == other.orientation);

  @override
  int get hashCode =>
      id.hashCode ^
      address.hashCode ^
      description.hashCode ^
      group.hashCode ^
      directionality.hashCode ^
      location.hashCode ^
      sensitivity.hashCode ^
      maxSpl.hashCode ^
      minSpl.hashCode ^
      frequencyResponse.hashCode ^
      position.hashCode ^
      orientation.hashCode;

  @override
  String toString() {
    return 'MicrophoneInfo{'
        ' id: $id,'
        ' address: $address,'
        ' description: $description,'
        ' group: $group,'
        ' directionality: $directionality,'
        ' location: $location,'
        ' sensitivity: $sensitivity,'
        ' maxSpl: $maxSpl,'
        ' minSpl: $minSpl,'
        ' frequencyResponse: $frequencyResponse,'
        ' position: $position,'
        ' orientation: $orientation,'
        '}';
  }

  MicrophoneInfo copyWith({
    int? id,
    String? address,
    String? description,
    int? group,
    int? directionality,
    int? location,
    double? sensitivity,
    double? maxSpl,
    double? minSpl,
    List<FreqResponse>? frequencyResponse,
    Coordinate3D? position,
    Coordinate3D? orientation,
  }) {
    return MicrophoneInfo(
      id: id ?? this.id,
      address: address ?? this.address,
      description: description ?? this.description,
      group: group ?? this.group,
      directionality: directionality ?? this.directionality,
      location: location ?? this.location,
      sensitivity: sensitivity ?? this.sensitivity,
      maxSpl: maxSpl ?? this.maxSpl,
      minSpl: minSpl ?? this.minSpl,
      frequencyResponse: frequencyResponse ?? this.frequencyResponse,
      position: position ?? this.position,
      orientation: orientation ?? this.orientation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'description': description,
      'group': group,
      'directionality': directionality,
      'location': location,
      'sensitivity': sensitivity,
      'maxSpl': maxSpl,
      'minSpl': minSpl,
      'frequencyResponse': frequencyResponse?.map((e) => e.toMap()).toList(),
      'position': position?.toList(),
      'orientation': orientation?.toList(),
    };
  }

  factory MicrophoneInfo.fromMap(Map<String, dynamic> map) {
    List<Object?>? freqLists = (map['frequencyResponse'] as List<Object?>?);
    final List<FreqResponse>? freqResponses = freqLists
        ?.map((freqList) => List<double>.from(freqList as List))
        .map((freqList) =>
            FreqResponse(frequency: freqList[0], response: freqList[1]))
        .toList();

    return MicrophoneInfo(
      id: map['id'] as int,
      address: map['address'] as String,
      description: map['description'] as String,
      group: map['group'] as int,
      directionality: map['directionality'] as int,
      location: map['location'] as int,
      sensitivity: map['sensitivity'] as double?,
      maxSpl: map['maxSpl'] as double?,
      minSpl: map['minSpl'] as double?,
      frequencyResponse: freqResponses,
      position: (map['position'] != null)
          ? Coordinate3D.fromList(map['position'])
          : null,
      orientation: (map['orientation'] != null)
          ? Coordinate3D.fromList(map['orientation'])
          : null,
    );
  }
}
