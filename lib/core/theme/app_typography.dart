import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle display(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: color ?? Theme.of(context).textTheme.displayLarge?.color ?? AppColors.darkText,
      letterSpacing: -0.5,
    );
  }

  static TextStyle headline(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: color ?? Theme.of(context).textTheme.headlineMedium?.color ?? AppColors.darkText,
      letterSpacing: -0.3,
    );
  }

  static TextStyle title(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Theme.of(context).textTheme.titleLarge?.color ?? AppColors.darkText,
      letterSpacing: -0.2,
    );
  }

  static TextStyle body(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.darkText,
    );
  }

  static TextStyle caption(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Theme.of(context).textTheme.bodySmall?.color ?? AppColors.mutedText,
    );
  }
}
