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

extension Abriviature on String {
  String get abrv {
    if (!contains(' ')) return substring(0, 1).toUpperCase();
    final index = indexOf(' ');
    final second = substring(index + 1, index + 2);
    return '${substring(0, 1)}$second'.toUpperCase();
  }
}

extension NameParce on String {
  String get naming {
    if (!contains('/')) return this;
    final index = indexOf('/');
    return substring(0, index);
  }
}
