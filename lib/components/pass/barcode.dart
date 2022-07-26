import 'package:json_annotation/json_annotation.dart';

part 'barcode.g.dart';

enum BarcodeFormat {
  qr("PKBarcodeFormatQR"),
  pdf417("PKBarcodeFormatPDF417"),
  aztec("PKBarcodeFormatAztec"),
  code128("PKBarcodeFormatCode128");

  const BarcodeFormat(this.key);
  final String key;

  factory BarcodeFormat.fromJson(String json) {
    switch (json) {
      case "PKBarcodeFormatQR":
        return BarcodeFormat.qr;
      case "PKBarcodeFormatPDF417":
        return BarcodeFormat.pdf417;
      case "PKBarcodeFormatAztec":
        return BarcodeFormat.aztec;
      case "PKBarcodeFormatCode128":
        return BarcodeFormat.code128;
      default:
        throw UnimplementedError("Not a valid BarcodeFormat: $json");
    }
  }
  String toJson() => key;
}

/// Information about a pass’s barcode.
@JsonSerializable()
class PassBarcode {
  const PassBarcode({
    this.altText,
    required this.format,
    required this.message,
    required this.messageEncoding,
  });

  /// *Optional.* Text displayed near the barcode. For example, a human-readable
  /// version of the barcode data in case the barcode doesn’t scan.
  final String? altText;

  /// *Required.* Barcode format.
  final BarcodeFormat format;

  /// *Required.* Message or payload to be displayed as a barcode.
  final String message;

  /// *Required.* Text encoding that is used to convert the message from the
  /// string representation to a data representation to render the barcode.
  /// The value is typically `iso-8859-1`, but you may use another encoding that
  /// is supported by your barcode scanning infrastructure.
  final String messageEncoding;

  factory PassBarcode.fromJson(Map<String, dynamic> json) =>
      _$PassBarcodeFromJson(json);
  Map<String, dynamic> toJson() => _$PassBarcodeToJson(this);
}
