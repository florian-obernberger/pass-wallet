import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';

class StyleKeyException implements Exception {
  @override
  String toString() => "No style key found! Valid keys are: "
      "[boardingPass, coupon, eventTicket, generic, storeCard]";
}

enum TransitType {
  air("PKTransitTypeAir"),
  boat("PKTransitTypeBoat"),
  bus("PKTransitTypeBus"),
  generic("PKTransitTypeGeneric"),
  train("PKTransitTypeTrain");

  const TransitType(this.key);
  final String key;

  factory TransitType.fromJson(String json) {
    switch (json) {
      case "PKTransitTypeAir":
        return TransitType.air;
      case "PKTransitTypeBoat":
        return TransitType.boat;
      case "PKTransitTypeBus":
        return TransitType.bus;
      case "PKTransitTypeGeneric":
        return TransitType.generic;
      case "PKTransitTypeTrain":
        return TransitType.train;
      default:
        throw UnimplementedError("Not a valid TransitType: $json");
    }
  }
  String toJson() => key;
}

/// Keys that define the structure of the pass.
/// These keys are used for all pass styles and partition the fields into the
/// various parts of the pass.
@JsonSerializable()
abstract class PassStyle {
  const PassStyle({
    this.auxiliaryFields,
    this.backFields,
    this.headerFields,
    this.primaryFields,
    this.secondaryFields,
  });

  /// *Optional.* Additional fields to be displayed on the front of the pass.
  final List<FieldDictionary>? auxiliaryFields;

  /// *Optional.* Fields to be on the back of the pass.
  final List<FieldDictionary>? backFields;

  /// *Optional.* Fields to be displayed in the header on the front of the pass.
  /// Use header fields sparingly; unlike all other fields, they remain visible
  /// when a stack of passes are displayed.
  final List<FieldDictionary>? headerFields;

  /// *Optional.* Fields to be displayed prominently on the front of the pass.
  final List<FieldDictionary>? primaryFields;

  /// *Optional.* Fields to be displayed on the front of the pass.
  final List<FieldDictionary>? secondaryFields;

  String get typeName;

  Map<String, dynamic> toJson() => _$PassStyleToJson(this);

  factory PassStyle.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("boardingPass")) {
      return BoardingPass.fromJson(json["boardingPass"]);
    } else if (json.containsKey("coupon")) {
      return BoardingPass.fromJson(json["coupon"]);
    } else if (json.containsKey("eventTicket")) {
      return BoardingPass.fromJson(json["eventTicket"]);
    } else if (json.containsKey("generic")) {
      return BoardingPass.fromJson(json["generic"]);
    } else if (json.containsKey("storeCard")) {
      return BoardingPass.fromJson(json["storeCard"]);
    } else {
      throw StyleKeyException();
    }
  }
}

@JsonSerializable()
class BoardingPass extends PassStyle {
  const BoardingPass({
    super.auxiliaryFields,
    super.backFields,
    super.headerFields,
    super.primaryFields,
    super.secondaryFields,
  });

  @override
  String get typeName => "boardingPass";
  factory BoardingPass.fromJson(Map<String, dynamic> json) =>
      _$BoardingPassFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoardingPassToJson(this);
}

@JsonSerializable()
class Coupon extends PassStyle {
  @override
  String get typeName => "coupon";
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}

@JsonSerializable()
class EventTicket extends PassStyle {
  @override
  String get typeName => "eventTicket";
  factory EventTicket.fromJson(Map<String, dynamic> json) =>
      _$EventTicketFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventTicketToJson(this);
}

@JsonSerializable()
class Generic extends PassStyle {
  @override
  String get typeName => "generic";
  factory Generic.fromJson(Map<String, dynamic> json) =>
      _$GenericFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenericToJson(this);
}

@JsonSerializable()
class StoreCard extends PassStyle {
  @override
  String get typeName => "storeCard";
  factory StoreCard.fromJson(Map<String, dynamic> json) =>
      _$StoreCardFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StoreCardToJson(this);
}
