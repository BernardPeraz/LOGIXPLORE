import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(color: Colors.black),
    headlineSmall: GoogleFonts.montserrat(color: Colors.black),
    titleSmall: GoogleFonts.montserrat(color: Colors.black),
    bodySmall: GoogleFonts.montserrat(color: Colors.black),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(color: Colors.white),
    headlineSmall: GoogleFonts.montserrat(color: Colors.white),
    titleSmall: GoogleFonts.montserrat(color: Colors.white),
    bodySmall: GoogleFonts.montserrat(color: Colors.white),
  );
}
