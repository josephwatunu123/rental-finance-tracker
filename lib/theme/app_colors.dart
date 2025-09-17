import 'dart:ui';

import 'package:flutter/cupertino.dart';


const Color blue1 = Color(0xff3A64E4);
const Color blue2 = Color(0xff4C2BF3);
const Color blue3 = Color(0xff2B6EF3);


Color lighten(Color color, [double amount = .1]) {
  final hsl = HSLColor.fromColor(color);

  return hsl
      .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
      .withSaturation((hsl.saturation + (amount / 2)).clamp(0.0, 1.0))
      .toColor();
}

Color darken(Color color, [double amount = .1]) {
  final hsl = HSLColor.fromColor(color);

  return hsl
      .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
      .withSaturation((hsl.saturation + (amount / 3)).clamp(0.0, 1.0))
      .toColor();
}


