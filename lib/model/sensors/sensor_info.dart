import 'package:snooper_android/model/sensors/sensor_type_wrapper.dart';

class SensorInfo {
  /// Name string of the sensor.
  /// The name is guaranteed to be unique for a particular sensor type.
  final String? name;

  /// Generic type of this sensor
  final SensorTypeWrapper type;

  /// The type of this sensor as a string
  final String? stringType;

  /// Returns true if the sensor is a wake-up sensor.
  ///
  /// More at:
  /// https://developer.android.com/reference/android/hardware/Sensor#isWakeUpSensor()
  final bool isWakeUpSensor;

  /// Each sensor has exactly one reporting mode associated with it.
  /// This method returns the reporting mode constant for this sensor type.
  final int reportingMode;

  /// Vendor string of this sensor.
  final String? vendor;

  /// Version of the sensor's module.
  final int version;

  /// Maximum range of the sensor in the sensor's unit.
  final double maximumRange;

  /// Resolution of the sensor in the sensor's unit
  final double resolution;

  /// This value is defined only for continuous and on-change sensors.
  /// It is the delay between two sensor events corresponding to the lowest frequency
  /// that this sensor supports.
  /// When lower frequencies are requested through registerListener() the events will
  /// be generated at this frequency instead.
  /// It can be used to estimate when the batch FIFO may be full.
  /// Older devices may set this value to zero.
  /// Ignore this value in case it is negative or zero.
  /// The max delay for this sensor in microseconds
  final int maxDelay;

  /// The minimum delay allowed between two events in microseconds or zero if this
  /// sensor only returns a value when the data it's measuring changes.
  /// Note that if the app does not have the
  /// android.Manifest.permission.HIGH_SAMPLING_RATE_SENSORS permission, the minimum
  /// delay is capped at 5000 microseconds (200 Hz).
  final int minDelay;

  /// The "power" current in mA used by this sensor while in use.
  /// Note this is NOT measured in Watts, so to yield milliWatts, nominal voltage
  /// of the battery has to be taken into account.
  ///
  /// More at:
  /// https://source.android.com/devices/sensors/power-use#power_measurement_process
  final double power;

  // region API >= 24

  /// Returns true if the sensor is a dynamic sensor (sensor added at runtime).
  final bool isDynamicSensor;

  /// Returns true if the sensor supports sensor additional information API
  final bool isAdditionalInfoSupported;

  // endregion

  // region API >= 31

  /// Get the highest supported direct report mode rate level of the sensor.
  ///
  /// More at: https://developer.android.com/reference/android/hardware/SensorDirectChannel#summary
  final int highestDirectReportRateLevel;

  const SensorInfo({
    this.name,
    required this.type,
    this.stringType,
    required this.isWakeUpSensor,
    required this.reportingMode,
    this.vendor,
    required this.version,
    required this.maximumRange,
    required this.resolution,
    required this.maxDelay,
    required this.minDelay,
    required this.power,
    required this.isDynamicSensor,
    required this.isAdditionalInfoSupported,
    required this.highestDirectReportRateLevel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          stringType == other.stringType &&
          isWakeUpSensor == other.isWakeUpSensor &&
          reportingMode == other.reportingMode &&
          vendor == other.vendor &&
          version == other.version &&
          maximumRange == other.maximumRange &&
          resolution == other.resolution &&
          maxDelay == other.maxDelay &&
          minDelay == other.minDelay &&
          power == other.power &&
          isDynamicSensor == other.isDynamicSensor &&
          isAdditionalInfoSupported == other.isAdditionalInfoSupported &&
          highestDirectReportRateLevel == other.highestDirectReportRateLevel);

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode ^
      stringType.hashCode ^
      isWakeUpSensor.hashCode ^
      reportingMode.hashCode ^
      vendor.hashCode ^
      version.hashCode ^
      maximumRange.hashCode ^
      resolution.hashCode ^
      maxDelay.hashCode ^
      minDelay.hashCode ^
      power.hashCode ^
      isDynamicSensor.hashCode ^
      isAdditionalInfoSupported.hashCode ^
      highestDirectReportRateLevel.hashCode;

  @override
  String toString() {
    return 'SensorInfo{'
        ' name: $name,'
        ' type: $type,'
        ' stringType: $stringType,'
        ' isWakeUpSensor: $isWakeUpSensor,'
        ' reportingMode: $reportingMode,'
        ' vendor: $vendor,'
        ' version: $version,'
        ' maximumRange: $maximumRange,'
        ' resolution: $resolution,'
        ' maxDelay: $maxDelay,'
        ' minDelay: $minDelay,'
        ' power: $power,'
        ' isDynamicSensor: $isDynamicSensor,'
        ' isAdditionalInfoSupported: $isAdditionalInfoSupported,'
        ' highestDirectReportRateLevel: $highestDirectReportRateLevel,'
        '}';
  }

  SensorInfo copyWith({
    String? name,
    SensorTypeWrapper? type,
    String? stringType,
    bool? isWakeUpSensor,
    int? reportingMode,
    String? vendor,
    int? version,
    double? maximumRange,
    double? resolution,
    int? maxDelay,
    int? minDelay,
    double? power,
    bool? isDynamicSensor,
    bool? isAdditionalInfoSupported,
    int? highestDirectReportRateLevel,
  }) {
    return SensorInfo(
      name: name ?? this.name,
      type: type ?? this.type,
      stringType: stringType ?? this.stringType,
      isWakeUpSensor: isWakeUpSensor ?? this.isWakeUpSensor,
      reportingMode: reportingMode ?? this.reportingMode,
      vendor: vendor ?? this.vendor,
      version: version ?? this.version,
      maximumRange: maximumRange ?? this.maximumRange,
      resolution: resolution ?? this.resolution,
      maxDelay: maxDelay ?? this.maxDelay,
      minDelay: minDelay ?? this.minDelay,
      power: power ?? this.power,
      isDynamicSensor: isDynamicSensor ?? this.isDynamicSensor,
      isAdditionalInfoSupported:
          isAdditionalInfoSupported ?? this.isAdditionalInfoSupported,
      highestDirectReportRateLevel:
          highestDirectReportRateLevel ?? this.highestDirectReportRateLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.typeValue,
      'stringType': stringType,
      'isWakeUpSensor': isWakeUpSensor,
      'reportingMode': reportingMode,
      'vendor': vendor,
      'version': version,
      'maximumRange': maximumRange,
      'resolution': resolution,
      'maxDelay': maxDelay,
      'minDelay': minDelay,
      'power': power,
      'isDynamicSensor': isDynamicSensor,
      'isAdditionalInfoSupported': isAdditionalInfoSupported,
      'highestDirectReportRateLevel': highestDirectReportRateLevel,
    };
  }

  factory SensorInfo.fromMap(Map<String, dynamic> map) {
    return SensorInfo(
      name: map['name'] as String,
      type: SensorTypeWrapper(typeValue: map['type'] as int),
      stringType: map['stringType'] as String,
      isWakeUpSensor: map['isWakeUpSensor'] as bool,
      reportingMode: map['reportingMode'] as int,
      vendor: map['vendor'] as String,
      version: map['version'] as int,
      maximumRange: map['maximumRange'] as double,
      resolution: map['resolution'] as double,
      maxDelay: map['maxDelay'] as int,
      minDelay: map['minDelay'] as int,
      power: map['power'] as double,
      isDynamicSensor: map['isDynamicSensor'] as bool,
      isAdditionalInfoSupported: map['isAdditionalInfoSupported'] as bool,
      highestDirectReportRateLevel: map['highestDirectReportRateLevel'] as int,
    );
  }
}
