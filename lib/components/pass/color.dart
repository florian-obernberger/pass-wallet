import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final _whiteSpaceRegex = RegExp(r"\s");
final _colorCheckRegex = RegExp(r"rgb\((\d{1,3},\s*){2}\d{1,3}\)");

class PassColor extends Color {
  const PassColor(int red, int blue, int green, [int alpha = 255])
      : super.fromARGB(alpha, red, green, blue);

  factory PassColor.fromJson(String json) {
    if (_colorCheckRegex.allMatches(json).length != 1) {
      throw FormatException("A css style triplet must have the following form: "
          "rgb(23, 187, 82) but was found to look like this: $json");
    }

    final values = json
        .substring(3, json.length - 1)
        .replaceAll(_whiteSpaceRegex, "")
        .split(',')
        .map<int>((e) => int.parse(e))
        .toList();

    if (values.length != 3) {
      throw FormatException(
          "A css style triplet must contain, well, 3 values, not ${values.length}");
    }

    return PassColor(values[0], values[1], values[2]);
  }
  factory PassColor.fromCssString(String cssString) =>
      PassColor.fromJson(cssString);

  String toJson() => "rgb($red, $green, $blue)";
  String toCssString() => toJson();
}
