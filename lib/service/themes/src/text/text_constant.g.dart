// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_constant.dart';

// **************************************************************************
// ThemeTextGenerator
// **************************************************************************

class $MyThemeText extends ThemeExtension<$MyThemeText> {
  final TextStyle title;
  final TextStyle base;
  final TextStyle baseLarge;
  final TextStyle baseSmall;
  final TextStyle searchBox;
  final TextStyle avatar;
  $MyThemeText({
    required this.title,
    required this.base,
    required this.baseLarge,
    required this.baseSmall,
    required this.searchBox,
    required this.avatar,
  });
  @override
  ThemeExtension<$MyThemeText> copyWith({
    TextStyle? title,
    TextStyle? base,
    TextStyle? baseLarge,
    TextStyle? baseSmall,
    TextStyle? searchBox,
    TextStyle? avatar,
  }) {
    return $MyThemeText(
      title: title ?? this.title,
      base: base ?? this.base,
      baseLarge: baseLarge ?? this.baseLarge,
      baseSmall: baseSmall ?? this.baseSmall,
      searchBox: searchBox ?? this.searchBox,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  ThemeExtension<$MyThemeText> lerp(
    ThemeExtension<$MyThemeText>? other,
    double t,
  ) {
    if (other is! $MyThemeText) {
      return this;
    }
    return $MyThemeText(
      title: TextStyle.lerp(title, other.title, t)!,
      base: TextStyle.lerp(base, other.base, t)!,
      baseLarge: TextStyle.lerp(baseLarge, other.baseLarge, t)!,
      baseSmall: TextStyle.lerp(baseSmall, other.baseSmall, t)!,
      searchBox: TextStyle.lerp(searchBox, other.searchBox, t)!,
      avatar: TextStyle.lerp(avatar, other.avatar, t)!,
    );
  }

  static get light => $MyThemeText(
        title: AppTextStyle.title,
        base: AppTextStyle.base,
        baseLarge: AppTextStyle.baseLarge,
        baseSmall: AppTextStyle.baseSmall,
        searchBox: AppTextStyle.searchBox,
        avatar: AppTextStyle.avatar,
      );
  static get dark => $MyThemeText(
        title: AppTextStyle.title,
        base: AppTextStyle.base,
        baseLarge: AppTextStyle.baseLarge,
        baseSmall: AppTextStyle.baseSmall,
        searchBox: AppTextStyle.searchBox,
        avatar: AppTextStyle.avatar,
      );
}
