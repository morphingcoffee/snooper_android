import 'package:flutter_test/flutter_test.dart';
import 'package:snooper_android/model/x509_signature_info.dart';

import '../shared_dummy_data/signatures.dart';

void main() {
  tearDown(() {});

  test('x509Signature_shouldRemainIndentical_onToMapFromMap', () async {
    final signature = dummySignatureWithAllFields();
    final otherSignature = X509SignatureInfo.fromMap(signature.toMap());
    expect(otherSignature, signature);
  });

  test('x509Signature_shouldRemainIndentical_onCopy', () async {
    final signature = dummySignatureWithAllFields();
    final copy = signature.shallowCopyWith();
    expect(copy, signature);
  });
}
