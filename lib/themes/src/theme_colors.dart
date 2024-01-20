part of '../theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color filterButtonFillColor;
  final Color avatarBC;
  final Color chartDate;
  final Color chartBottom;
  final Color myMessage;
  final Color otherMessage;
  final Color hint;
  final Color avatarText;

  const ThemeColors({
    required this.filterButtonFillColor,
    required this.avatarBC,
    required this.chartDate,
    required this.myMessage,
    required this.otherMessage,
    required this.avatarText,
    required this.chartBottom,
    required this.hint,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? filterButtonFillColor,
    Color? avatarBC,
    Color? chartDate,
    Color? chartBottom,
    Color? myMessage,
    Color? otherMessage,
    Color? hint,
    Color? avatarText,
  }) {
    return ThemeColors(
        filterButtonFillColor:
            filterButtonFillColor ?? this.filterButtonFillColor,
        avatarBC: avatarBC ?? this.avatarBC,
        chartBottom: chartBottom ?? this.chartBottom,
        myMessage: myMessage ?? this.myMessage,
        otherMessage: otherMessage ?? this.otherMessage,
        hint: hint ?? this.hint,
        avatarText: avatarText ?? this.avatarText,
        chartDate: chartDate ?? this.chartDate);
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      chartDate: Color.lerp(chartDate, other.chartDate, t)!,
      myMessage: Color.lerp(myMessage, other.myMessage, t)!,
      avatarText: Color.lerp(avatarText, other.avatarText, t)!,
      otherMessage: Color.lerp(otherMessage, other.otherMessage, t)!,
      chartBottom: Color.lerp(chartBottom, other.chartBottom, t)!,
      filterButtonFillColor:
          Color.lerp(filterButtonFillColor, other.filterButtonFillColor, t)!,
      avatarBC: Color.lerp(avatarBC, other.avatarBC, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
    );
  }

  static get light => const ThemeColors(
      myMessage: AppColors.myMessage,
      otherMessage: AppColors.otherMessage,
      chartBottom: AppColors.chartBottom,
      avatarText: AppColors.white,
      filterButtonFillColor: AppColors.grey,
      avatarBC: AppColors.blue,
      hint: AppColors.hint,
      chartDate: AppColors.chartDateDiv);

  static get dark => const ThemeColors(
        myMessage: AppColors.myMessage,
        avatarText: AppColors.white,
        otherMessage: AppColors.otherMessage,
        chartBottom: AppColors.chartBottom,
        hint: AppColors.hint,
        filterButtonFillColor: AppColors.white,
        avatarBC: AppColors.blue,
        chartDate: AppColors.chartDateDiv,
      );
}
