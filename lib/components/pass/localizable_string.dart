import 'dart:io';

class LocalizableString {
  const LocalizableString(this.value);
  final String value;

  String localize(String locale, Directory directory) {
    return value;
  }

  factory LocalizableString.fromJson(String json) => LocalizableString(json);
  String toJson() => value;
}
