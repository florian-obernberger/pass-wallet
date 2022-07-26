import 'package:json_annotation/json_annotation.dart';
import 'package:pass_wallet/components/pass/localizable_string.dart';

part 'field_dict.g.dart';

@JsonSerializable()
class AttributedValue {
  const AttributedValue._(this.value);
  final dynamic value;

  factory AttributedValue(dynamic value) {
    if (value is int || value is double) {
      return AttributedNumber(value.toDouble());
    } else if (double.tryParse(value) != null) {
      return AttributedNumber(double.parse(value));
    } else if (DateTime.tryParse(value) != null) {
      return AttributedDateTime(DateTime.parse(value));
    } else {
      return AttributedString(value.toString());
    }
  }
}

@JsonSerializable()
class AttributedDateTime implements AttributedValue {
  const AttributedDateTime(this.value);
  @override
  final DateTime value;
}

@JsonSerializable()
class AttributedNumber implements AttributedValue {
  const AttributedNumber(this.value);
  @override
  final double value;
}

@JsonSerializable()
class AttributedString implements AttributedValue {
  const AttributedString(this.value);
  @override
  final String value;
}

@JsonSerializable()
class FieldDictionary {
  final AttributedValue? attributedValue;
  final LocalizableString? changeMessage;
  final List<String>? dataDetectorTypes;
  final String key;
  final LocalizableString? label;
  final String? textAlignment;
  final AttributedValue value;
}
