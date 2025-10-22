import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:studydesign2zzdatabaseplaylist/src/utils/theme/widget_themes/outlined_button_themr.dart';
import 'package:studydesign2zzdatabaseplaylist/src/utils/theme/widget_themes/text_field_theme.dart';

import 'widget_themes/text_themes.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
