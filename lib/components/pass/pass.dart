// import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pass_wallet/components/pass/barcode.dart';
import 'package:pass_wallet/components/pass/beacon.dart';
import 'package:pass_wallet/components/pass/color.dart';
import 'package:pass_wallet/components/pass/localizable_string.dart';
import 'package:pass_wallet/components/pass/location.dart';
import 'package:pass_wallet/components/pass/nfc.dart';
import 'package:pass_wallet/components/pass/style.dart';

part 'pass.g.dart';

@JsonSerializable()
class Pass {
  const Pass();

  //! Top Level Keys

  /// *Required.* Brief description of the pass.
  /// Don’t try to include all of the data on the pass in its description, just
  /// include enough detail to distinguish passes of the same type.
  @JsonKey(required: true, disallowNullValue: true)
  final LocalizableString description;

  /// *Required.* Version of the file format. The value must be 1.
  @JsonKey(required: true, disallowNullValue: true)
  final int formatVersion;

  /// *Required.* Display name of the organization that originated and signed
  /// the pass.
  @JsonKey(required: true, disallowNullValue: true)
  final LocalizableString organizationName;

  /// *Required.* Pass type identifier, as issued by Apple. The value must
  /// correspond with your signing certificate.
  @JsonKey(required: true, disallowNullValue: true)
  final String passTypeIdentifier;

  /// *Required.* Serial number that uniquely identifies the pass. No two passes
  /// with the same pass type identifier may have the same serial number.
  @JsonKey(required: true, disallowNullValue: true)
  final String serialNumber;

  /// *Required.* Team identifier of the organization that originated and signed
  /// the pass, as issued by Apple.
  @JsonKey(required: true, disallowNullValue: true)
  final String teamIdentifier;

  //! Associated App Keys

  /// *Optional.* A URL to be passed to the associated app when launching it.
  /// The app receives this URL in the `application:didFinishLaunchingWithOptions:`
  /// and `application:openURL:options:` methods of its app delegate.
  /// If this key is present, the `associatedStoreIdentifiers` key must also be
  /// present.
  final String? appLaunchURL;

  /// *Optional.* A list of iTunes Store item identifiers for the associated
  /// apps. Only one item in the list is used—the first item identifier for an
  /// app compatible with the current device. If the app is not installed, the
  /// link opens the App Store and shows the app. If the app is already
  /// installed, the link launches the app.
  final List<double>? associatedStoreIdentifiers;

  //! Companion App Keys

  /// *Optional.* Custom information for companion apps. This data is not
  /// displayed to the user.
  /// For example, a pass for a cafe could include information about the user’s
  /// favorite drink and sandwich in a machine-readable form for the companion
  /// app to read, making it easy to place an order for “the usual” from the app.
  final Map<String, dynamic>? userInfo;

  //! Expiration Keys

  /// *Optional.* Date and time when the pass expires.
  /// The value must be a complete date with hours and minutes, and may optionally include seconds.
  final DateTime? expirationDate;

  /// Optional. Indicates that the pass is void—for example, a one time use
  /// coupon that has been redeemed. The default value is `false`.
  final bool voided;

  //! Relevance Keys

  /// *Optional.* Beacons marking locations where the pass is relevant.
  /// For these dictionaries’ keys, see [PassBeacon].
  final List<PassBeacon>? beacons;

  /// *Optional.* Locations where the pass is relevant. For example, the
  /// location of your store.
  /// For these dictionaries’ keys, see [PassLocation].
  final List<PassLocation>? locations;

  /// *Optional.* Maximum distance in meters from a relevant latitude and
  /// longitude that the pass is relevant. This number is compared to the pass’s
  /// default distance and the smaller value is used.
  final double? maxDistance;

  /// Recommended for event tickets and boarding passes; otherwise optional.
  /// Date and time when the pass becomes relevant. For example, the start time
  /// of a movie.
  ///
  /// The value must be a complete date with hours and minutes, and may
  /// optionally include seconds.
  final DateTime? relevantTime;

  //! Style Keys

  @JsonKey(required: true, disallowNullValue: true, fromJson: Pass.fromJson)
  final PassStyle styleKeys;

  //! Visual Appearance Keys

  /// *Optional.* Information specific to the pass’s barcode. For this
  /// dictionary’s keys, see [PassBarcode].
  @Deprecated("Use barcodes instead!")
  final PassBarcode? barcode;

  /// *Optional.* Information specific to the pass’s barcode. The system uses
  /// the first valid barcode dictionary in the array. Additional dictionaries
  /// can be added as fallbacks. For this dictionary’s keys, see [PassBarcode].
  final List<PassBarcode>? barcodes;

  /// *Optional.* Background color of the pass, specified as a [PassColor].
  /// For example, `PassColor(23, 187, 82)`.
  final PassColor? backgroundColor;

  /// Optional. Foreground color of the pass, specified as a [PassColor].
  /// For example, `PassColor(100, 10, 110)`.
  final PassColor? foregroundColor;

  /// Optional. Foreground color of the pass, specified as a [PassColor].
  /// For example, `PassColor(255, 255, 255)`.
  final PassColor? labelColor;

  /// *Optional.* Text displayed next to the logo on the pass.
  final LocalizableString? logoText;

  /// *Optional for event tickets and boarding passes; otherwise not allowed.*
  /// Identifier used to group related passes. If a grouping identifier is
  /// specified, passes with the same style, pass type identifier, and grouping
  /// identifier are displayed as a group. Otherwise, passes are grouped
  /// automatically.
  ///
  /// Use this to group passes that are tightly related, such as the boarding
  /// passes for different connections of the same trip.
  final String? groupingIdentifier;

  @Deprecated("Not used anymore!")
  final bool suppressStripShine;

  /// The authentication token to use with the web service. The token must be
  /// 16 characters or longer.
  final String? authenticationToken;

  /// The URL of a web service that conforms to the API described in
  /// [PassKit Web Service Reference](https://developer.apple.com/library/archive/documentation/PassKit/Reference/PassKit_WebService/WebService.html#//apple_ref/doc/uid/TP40011988).
  /// The web service must use the HTTPS protocol; the leading `https://`
  /// is included in the value of this key.
  /// On devices configured for development, there is UI in Settings to allow
  /// HTTP web services.
  final String? webServiceURL;

  /// Optional. Information used for Value Added Service Protocol transactions.
  /// For this dictionary’s keys, see [PassN´fc].
  final PassNfc? nfc;

  factory Pass.fromJson(Map<String, dynamic> json) => _$PassFromJson(json);
  Map<String, dynamic> toJson() {
    final json = _$PassToJson(this);
    final styleJson = json.remove("styleKeys");
    json[styleKeys.typeName] = styleJson;

    return json;
  }
}
