import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: Color.fromARGB(255, 0, 0, 0),
        floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      );
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: tPrimaryColor,
        floatingLabelStyle: TextStyle(color: tPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: tPrimaryColor),
        ),
      );
}
