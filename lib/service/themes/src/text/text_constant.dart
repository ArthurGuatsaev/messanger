import 'package:flutter/material.dart';
// import 'package:theme_code_gen/theme_code_gen.dart';
part 'text_constant.g.dart';

// @text_anotation
abstract class AppTextStyle {
  static TextStyle title =
      const TextStyle(fontSize: 32, fontWeight: FontWeight.w600);
  static TextStyle base =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle baseLarge =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static TextStyle baseSmall =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle searchBox =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle avatar =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
}
