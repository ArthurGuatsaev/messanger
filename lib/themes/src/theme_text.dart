part of '../theme.dart';

class ThemeText extends ThemeExtension<ThemeText> {
  final TextStyle lastMessage;
  final TextStyle chartDate;
  final TextStyle hintStyle;
  final TextStyle avatarStyle;

  const ThemeText(
      {required this.lastMessage,
      required this.chartDate,
      required this.avatarStyle,
      required this.hintStyle});

  @override
  ThemeExtension<ThemeText> copyWith({
    TextStyle? lastMessage,
    TextStyle? chartDate,
    TextStyle? hintStyle,
    TextStyle? avatarStyle,
  }) {
    return ThemeText(
      hintStyle: hintStyle ?? this.hintStyle,
      avatarStyle: avatarStyle ?? this.avatarStyle,
      lastMessage: lastMessage ?? this.lastMessage,
      chartDate: chartDate ?? this.chartDate,
    );
  }

  static get light => ThemeText(
      lastMessage: bodySmall.copyWith(color: AppColors.grey),
      hintStyle: hintText.copyWith(color: AppColors.hint),
      avatarStyle: avatarText.copyWith(color: AppColors.white),
      chartDate: chartDateText.copyWith(color: AppColors.chartDateText));

  static get dark => ThemeText(
      lastMessage: bodySmall.copyWith(color: AppColors.grey),
      hintStyle: hintText.copyWith(color: AppColors.hint),
      avatarStyle: avatarText.copyWith(color: AppColors.white),
      chartDate: chartDateText.copyWith(color: AppColors.chartDateText));

  @override
  ThemeExtension<ThemeText> lerp(
      covariant ThemeExtension<ThemeText>? other, double t) {
    if (other is! ThemeText) {
      return this;
    }
    return ThemeText(
      lastMessage: TextStyle.lerp(lastMessage, other.lastMessage, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
      avatarStyle: TextStyle.lerp(hintStyle, other.avatarStyle, t)!,
      chartDate: TextStyle.lerp(chartDate, other.chartDate, t)!,
    );
  }
}
