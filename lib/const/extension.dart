import 'package:flutter/material.dart';
import '../themes/theme.dart';

extension BuildContextExt on BuildContext {
  ThemeText get text => Theme.of(this).extension<ThemeText>()!;
  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension DateString on DateTime {
  String get chartD {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final init = DateTime(year, month, day);
    if (today == init) return 'Сегодня';
    if (today.difference(init).inDays < 2) return 'Вчера';
    final d = day.toString().length < 2 ? '0$day' : '$day';
    final m = month.toString().length < 2 ? '0$month' : '$month';
    return '$d.$m.$year';
  }
}
