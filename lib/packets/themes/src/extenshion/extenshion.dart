import 'package:flutter/material.dart';
import 'package:messanger/packets/themes/src/colors/color_constant.dart';

import '../text/text_constant.dart';

extension BuildContextExt on BuildContext {
  $MyThemeColor get color => Theme.of(this).extension<$MyThemeColor>()!;
  $MyThemeText get text => Theme.of(this).extension<$MyThemeText>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
