import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Information about a location.
@JsonSerializable()
class PassLocation {
  const PassLocation({
    this.altitude,
    required this.latitude,
    required this.longitude,
    this.relevantText,
  });

  /// *Optional.* Altitude, in meters, of the location.
  final double? altitude;

  /// *Required.* Latitude, in degrees, of the location.
  final double latitude;

  /// *Required.* Longitude, in degrees, of the location.
  final double longitude;

  /// *Optional.* Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// "Store nearby on 1st and Main."
  final String? relevantText;

  factory PassLocation.fromJson(Map<String, dynamic> json) =>
      _$PassLocationFromJson(json);
  Map<String, dynamic> toJson() => _$PassLocationToJson(this);
}
