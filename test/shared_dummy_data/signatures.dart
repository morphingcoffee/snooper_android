import 'dart:typed_data';

import 'package:snooper_android/model/x509_signature_info.dart';

X509SignatureInfo dummySignatureWithAllFields() {
  return X509SignatureInfo(
    subjectDN: 'subjectDN',
    issuerDN: 'issuerDN',
    serialNumber: 'serialNumber',
    notBefore: 12345,
    notAfter: 54321,
    sigAlgName: 'sigAlgName',
    version: 123,
    publicKeyAlgName: 'publicKeyAlgName',
    publicKey: Uint8List.fromList('publicKey'.codeUnits),
    signature: Uint8List.fromList('signature'.codeUnits),
  );
}
