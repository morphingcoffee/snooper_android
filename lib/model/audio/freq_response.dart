/// [FreqResponse] data class encapsulates a single frequency response.
/// [frequency] in represented in Hz, whereas [response] is in dB.
class FreqResponse {
  final double frequency;
  final double response;

  const FreqResponse({
    required this.frequency,
    required this.response,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FreqResponse &&
          runtimeType == other.runtimeType &&
          frequency == other.frequency &&
          response == other.response);

  @override
  int get hashCode => frequency.hashCode ^ response.hashCode;

  @override
  String toString() {
    return 'FreqResponse{' ' freq: $frequency,' ' response: $response,' '}';
  }

  FreqResponse copyWith({
    double? frequency,
    double? response,
  }) {
    return FreqResponse(
      frequency: frequency ?? this.frequency,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'frequency': frequency,
      'response': response,
    };
  }

  factory FreqResponse.fromMap(Map<String, dynamic> map) {
    return FreqResponse(
      frequency: map['frequency'] as double,
      response: map['response'] as double,
    );
  }
}
