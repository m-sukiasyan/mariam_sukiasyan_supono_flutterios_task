import 'package:flutter/material.dart';

class TextStyleTheme {
  static TextStyleTheme? _instance;

  TextStyleTheme._();

  static TextStyleTheme get instance => _instance ??= TextStyleTheme._();

  TextStyle getStyle(TextStyle style, Color color,
      {TextDecoration decoration = TextDecoration.none}) {
    return style.copyWith(color: color, decoration: decoration);
  }

  /**
   *  height = lineHeight / fontSize
   * */
  /**
   *  Lato-Bold
   * */
  static const TextStyle latoBoldW800S20 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      fontFamily: "Lato-Bold",
      height: 1.7);

  static const TextStyle latoBoldW800S23 = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w800,
      fontFamily: "Lato-Bold",
      height: 1.48);

  static const TextStyle latoBoldW800S25 = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      fontFamily: "Lato-Bold",
      height: 1.36);

  static const TextStyle latoBoldW800S30 = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w800,
      fontFamily: "Lato-Bold",
      height: 1.33);

  /**
   *  Lato-Medium
   * */
  static const TextStyle latoW500S13 = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: "Lato",
      height: 1.69);
  static const TextStyle latoW500S15 = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: "Lato",
      height: 1.33);
  static const TextStyle latoW600S15 = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: "Lato",
      height: 1.733);
  static const TextStyle latoW500S16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Lato",
      height: 2.125);
  static const TextStyle latoW700S17 = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontFamily: "Lato",
      height: 1.2);

  /**
   *  Lato-Regular
   * */
  static const TextStyle latoW400S16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: "Lato",
      height: 2.125);
  static const TextStyle latoW600S16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Lato",
      height: 1.625);
}
