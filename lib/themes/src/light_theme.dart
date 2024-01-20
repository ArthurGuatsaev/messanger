part of '../theme.dart';

ThemeData createLightTheme() {
  return ThemeData(
    textTheme: createTextTheme(),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.light,
      ThemeText.light,
    ],
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.white,
      // titleTextStyle: .copyWith(
      //   color: AppColors.black,
      //   fontSize: 20,
      //   fontWeight: FontWeight.w500,
      // ),
      // contentTextStyle: headline1.copyWith(
      //   color: AppColors.black,
      // ),
    ),
    focusColor: Colors.blue.withOpacity(0.2),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );
}
