import 'dart:convert';
import 'dart:typed_data';

Uint8List? stringToBytes(String? image) {
  if (image == null || image.isEmpty) return null;
  try {
    final cleanBase64 = image.replaceAll(RegExp(r'\s+'), '');

    return base64Decode(cleanBase64);
  } catch (e) {
    return null;
  }
}
