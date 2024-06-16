part of '../theme.dart';

ThemeData createLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      $MyThemeColor.light,
      $MyThemeText.light,
    ],
    textTheme: TextTheme(
      bodyLarge: AppTextStyle.baseLarge,
      titleLarge: AppTextStyle.title,
      bodySmall: AppTextStyle.baseSmall,
      bodyMedium: AppTextStyle.base,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgLight,
    ),
    scaffoldBackgroundColor: AppColors.bgLight,
  );
}
