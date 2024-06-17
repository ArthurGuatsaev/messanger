import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../packets/themes/src/colors/color_constant.dart';

import '../packets/themes/src/text/text_constant.dart';

extension BuildContextExt on BuildContext {
  $MyThemeColor get color => Theme.of(this).extension<$MyThemeColor>()!;
  $MyThemeText get text => Theme.of(this).extension<$MyThemeText>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension SubScriptionVerify on Duration {
  bool get subDuration {
    final durationWithSubscribe = kDebugMode ? inMinutes : inDays;
    return kDebugMode ? durationWithSubscribe <= 3 : durationWithSubscribe <= 7;
  }
}
