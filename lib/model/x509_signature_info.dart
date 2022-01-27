import 'dart:typed_data';

class X509SignatureInfo {
  /// The subject (subject distinguished name) value from the certificate.
  /// If the subject value is empty, then the getName() method of the returned
  /// Principal object returns an empty string ("").
  final String? subjectDN;

  /// Gets the issuer (issuer distinguished name) value from the certificate.
  /// The issuer name identifies the entity that signed (and issued) the certificate
  final String? issuerDN;

  /// The serialNumber value from the certificate.
  /// The serial number is an integer assigned by the certification authority to
  /// each certificate.
  /// It must be unique for each certificate issued by a given CA
  /// (i.e., the issuer name and serial number identify a unique certificate)
  final String? serialNumber;

  /// Certificate validity start date.
  /// Number of milliseconds since January 1, 1970, 00:00:00 GMT represented
  /// by this date.
  final int notBefore;

  /// Certificate validity end date.
  /// Number of milliseconds since January 1, 1970, 00:00:00 GMT represented by
  /// this date.
  final int notAfter;

  /// Signature algorithm name for the certificate signature algorithm.
  /// The algorithm name is determined from the algorithm OID string.
  final String? sigAlgName;

  /// Version (version number) value from the certificate
  final int version;

  /// Returns the standard algorithm name for this key.
  /// For example, "DSA" would indicate that this key is a DSA key
  final String? publicKeyAlgName;

  /// Returns the key in its primary encoding format, or null if this key does
  /// not support encoding.
  final Uint8List? publicKey;

  /// Returns the encoded form of this certificate.
  /// It is assumed that each certificate type would have only a single form
  /// of encoding;
  /// for example, X.509 certificates would be encoded as ASN.1 DER.
  final Uint8List? signature;

  const X509SignatureInfo({
    this.subjectDN,
    this.issuerDN,
    required this.serialNumber,
    required this.notBefore,
    required this.notAfter,
    this.sigAlgName,
    required this.version,
    this.publicKeyAlgName,
    required this.publicKey,
    required this.signature,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is X509SignatureInfo &&
          runtimeType == other.runtimeType &&
          subjectDN == other.subjectDN &&
          issuerDN == other.issuerDN &&
          serialNumber == other.serialNumber &&
          notBefore == other.notBefore &&
          notAfter == other.notAfter &&
          sigAlgName == other.sigAlgName &&
          version == other.version &&
          publicKeyAlgName == other.publicKeyAlgName &&
          publicKey == other.publicKey &&
          signature == other.signature);

  @override
  int get hashCode =>
      subjectDN.hashCode ^
      issuerDN.hashCode ^
      serialNumber.hashCode ^
      notBefore.hashCode ^
      notAfter.hashCode ^
      sigAlgName.hashCode ^
      version.hashCode ^
      publicKeyAlgName.hashCode ^
      publicKey.hashCode ^
      signature.hashCode;

  @override
  String toString() {
    return 'X509SignatureInfo{'
        ' subjectDN: $subjectDN,'
        ' issuerDN: $issuerDN,'
        ' serialNumber: $serialNumber,'
        ' notBefore: $notBefore,'
        ' notAfter: $notAfter,'
        ' sigAlgName: $sigAlgName,'
        ' version: $version,'
        ' publicKeyAlgName: $publicKeyAlgName,'
        ' publicKey: $publicKey,'
        ' signature: $signature,'
        '}';
  }

  X509SignatureInfo shallowCopyWith({
    String? subjectDN,
    String? issuerDN,
    String? serialNumber,
    int? notBefore,
    int? notAfter,
    String? sigAlgName,
    int? version,
    String? publicKeyAlgName,
    Uint8List? publicKey,
    Uint8List? signature,
  }) {
    return X509SignatureInfo(
      subjectDN: subjectDN ?? this.subjectDN,
      issuerDN: issuerDN ?? this.issuerDN,
      serialNumber: serialNumber ?? this.serialNumber,
      notBefore: notBefore ?? this.notBefore,
      notAfter: notAfter ?? this.notAfter,
      sigAlgName: sigAlgName ?? this.sigAlgName,
      version: version ?? this.version,
      publicKeyAlgName: publicKeyAlgName ?? this.publicKeyAlgName,
      publicKey: publicKey ?? this.publicKey,
      signature: signature ?? this.signature,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectDN': subjectDN,
      'issuerDN': issuerDN,
      'serialNumber': serialNumber,
      'notBefore': notBefore,
      'notAfter': notAfter,
      'sigAlgName': sigAlgName,
      'version': version,
      'publicKeyAlgName': publicKeyAlgName,
      'publicKey': publicKey,
      'signature': signature,
    };
  }

  factory X509SignatureInfo.fromMap(Map<String, dynamic> map) {
    return X509SignatureInfo(
      subjectDN: map['subjectDN'] as String?,
      issuerDN: map['issuerDN'] as String?,
      serialNumber: map['serialNumber'] as String?,
      notBefore: map['notBefore'] as int,
      notAfter: map['notAfter'] as int,
      sigAlgName: map['sigAlgName'] as String?,
      version: map['version'] as int,
      publicKeyAlgName: map['publicKeyAlgName'] as String?,
      publicKey: map['publicKey'] as Uint8List?,
      signature: map['signature'] as Uint8List?,
    );
  }
}
