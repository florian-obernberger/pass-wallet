import 'package:json_annotation/json_annotation.dart';

part 'beacon.g.dart';

/// Information about a location beacon.
@JsonSerializable()
class PassBeacon {
  const PassBeacon({
    this.major,
    this.minor,
    required this.proximityUUID,
    this.relevantText,
  });

  /// *Optional.* Major identifier of a Bluetooth Low Energy location beacon.
  final int? major;

  /// *Optional.* Minor identifier of a Bluetooth Low Energy location beacon.
  final int? minor;

  /// *Required.* Unique identifier of a Bluetooth Low Energy location beacon.
  final String proximityUUID;

  /// *Optional.* Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as "Store
  /// nearby on 1st and Main."
  final String? relevantText;

  factory PassBeacon.fromJson(Map<String, dynamic> json) =>
      _$PassBeaconFromJson(json);
  Map<String, dynamic> toJson() => _$PassBeaconToJson(this);
}
