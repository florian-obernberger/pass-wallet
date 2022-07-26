import 'package:json_annotation/json_annotation.dart';

part 'nfc.g.dart';

/// Information about the NFC payload passed to an Apple Pay terminal.
@JsonSerializable()
class PassNfc {
  const PassNfc({required this.message, this.encryptionPublicKey});

  /// *Required.* The payload to be transmitted to the Apple Pay terminal. Must
  /// be 64 bytes or less. Messages longer than 64 bytes are truncated by
  /// the system.
  final String message;

  /// Optional. The public encryption key used by the Value Added Services
  /// protocol. Use a Base64 encoded X.509 SubjectPublicKeyInfo structure
  /// containing a ECDH public key for group P256.
  final String? encryptionPublicKey;

  factory PassNfc.fromJson(Map<String, dynamic> json) =>
      _$PassNfcFromJson(json);
  Map<String, dynamic> toJson() => _$PassNfcToJson(this);
}
