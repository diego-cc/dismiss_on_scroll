import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_demo/app.dart';
import 'package:sizer/sizer.dart';

extension AppTheme on App {
  get defaultTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF544179),
        textTheme: GoogleFonts.mulishTextTheme().copyWith(
          bodyText1: GoogleFonts.mulish().copyWith(
            color: Colors.white,
            fontSize: 18.0.sp,
            letterSpacing: 1.0,
            height: 1.5,
          ),
        ),
      );
}
