// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_constant.dart';

// **************************************************************************
// ThemeColorGenerator
// **************************************************************************

class $MyThemeColor extends ThemeExtension<$MyThemeColor> {
  final Color bg;
  final Color commentColor;
  final Color text;
  final Color textBodyLarge;
  final Color textBodySmall;
  final Color textTitleLarge;
  final Color searchBox;
  final Color sentMessage;
  final Color recieveMessage;
  final Color dateChat;
  $MyThemeColor({
    required this.bg,
    required this.commentColor,
    required this.text,
    required this.textBodyLarge,
    required this.textBodySmall,
    required this.textTitleLarge,
    required this.searchBox,
    required this.sentMessage,
    required this.recieveMessage,
    required this.dateChat,
  });
  @override
  ThemeExtension<$MyThemeColor> copyWith({
    Color? bg,
    Color? commentColor,
    Color? text,
    Color? textBodyLarge,
    Color? textBodySmall,
    Color? textTitleLarge,
    Color? searchBox,
    Color? sentMessage,
    Color? recieveMessage,
    Color? dateChat,
  }) {
    return $MyThemeColor(
      bg: bg ?? this.bg,
      commentColor: commentColor ?? this.commentColor,
      text: text ?? this.text,
      textBodyLarge: textBodyLarge ?? this.textBodyLarge,
      textBodySmall: textBodySmall ?? this.textBodySmall,
      textTitleLarge: textTitleLarge ?? this.textTitleLarge,
      searchBox: searchBox ?? this.searchBox,
      sentMessage: sentMessage ?? this.sentMessage,
      recieveMessage: recieveMessage ?? this.recieveMessage,
      dateChat: dateChat ?? this.dateChat,
    );
  }

  @override
  ThemeExtension<$MyThemeColor> lerp(
    ThemeExtension<$MyThemeColor>? other,
    double t,
  ) {
    if (other is! $MyThemeColor) {
      return this;
    }
    return $MyThemeColor(
      bg: Color.lerp(bg, other.bg, t)!,
      commentColor: Color.lerp(commentColor, other.commentColor, t)!,
      text: Color.lerp(text, other.text, t)!,
      textBodyLarge: Color.lerp(textBodyLarge, other.textBodyLarge, t)!,
      textBodySmall: Color.lerp(textBodySmall, other.textBodySmall, t)!,
      textTitleLarge: Color.lerp(textTitleLarge, other.textTitleLarge, t)!,
      searchBox: Color.lerp(searchBox, other.searchBox, t)!,
      sentMessage: Color.lerp(sentMessage, other.sentMessage, t)!,
      recieveMessage: Color.lerp(recieveMessage, other.recieveMessage, t)!,
      dateChat: Color.lerp(dateChat, other.dateChat, t)!,
    );
  }

  static get light => $MyThemeColor(
        bg: AppColors.bgLight,
        commentColor: AppColors.commentColorLight,
        text: AppColors.textLight,
        textBodyLarge: AppColors.textBodyLargeLight,
        textBodySmall: AppColors.textBodySmallLight,
        textTitleLarge: AppColors.textTitleLargeLight,
        searchBox: AppColors.searchBoxLight,
        sentMessage: AppColors.sentMessageLight,
        recieveMessage: AppColors.recieveMessageLight,
        dateChat: AppColors.dateChatLight,
      );
  static get dark => $MyThemeColor(
        bg: AppColors.bgDark,
        commentColor: AppColors.commentColorDark,
        text: AppColors.textDark,
        textBodyLarge: AppColors.textBodyLargeDark,
        textBodySmall: AppColors.textBodySmallDark,
        textTitleLarge: AppColors.textTitleLargeDark,
        searchBox: AppColors.searchBoxDark,
        sentMessage: AppColors.sentMessageDark,
        recieveMessage: AppColors.recieveMessageDark,
        dateChat: AppColors.dateChatDark,
      );
}
