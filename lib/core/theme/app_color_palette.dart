import 'package:flutter/material.dart';

class AppColorPalette {
  final MaterialColor primarySwatch;
  final MaterialColor secondarySwatch;
  final MaterialColor additionalSwatch1;
  final MaterialColor whiteColorPrimary;
  final Color transparentColor;
  final Color backgroundColor;
  final Color redDark;
  final Color primaryBlue;
  final Color primaryDarkblue;
  final Color stroke;
  final Color primaryGrey;
  final Color redBackground;
  final Color greenDark;
  final Color greenBackground;
  AppColorPalette({
    required this.primarySwatch,
    required this.secondarySwatch,
    required this.additionalSwatch1,
    required this.whiteColorPrimary,
    required this.transparentColor,
    required this.backgroundColor,
    required this.redDark,
    required this.primaryBlue,
    required this.primaryDarkblue,
    required this.stroke,
    required this.primaryGrey,
    required this.redBackground,
    required this.greenDark,
    required this.greenBackground,
  });
}

AppColorPalette lightColorPalette = AppColorPalette(
  primarySwatch: const MaterialColor(800, {}),
  secondarySwatch: const MaterialColor(600, {}),
  additionalSwatch1: const MaterialColor(800, {}),
  whiteColorPrimary: const MaterialColor(900, {
    900: Color(0xFFFFFFFF),
    800: Color(0xFFFAFAFA),
    700: Color(0xFFF5F5F5),
    600: Color(0xFFF9F9F9),
  }),
  transparentColor: Colors.transparent,
  redDark: const Color(0xFFF51F1F),
  backgroundColor: const Color(0xFFEDF4FF),
  stroke: const Color(0xFFB3BAC6),
  greenBackground: const Color(0xFFE0FFDF),
  greenDark: const Color(0xFF04B201),
  primaryBlue: const Color(0xFF0060F7),
  primaryDarkblue: const Color(0xFF1A4563),
  primaryGrey: const Color(0xFF757F8E),
  redBackground: const Color(0xFFFFEDED),
);
const TextTheme lightTextTheme = TextTheme(
  ///Mobile/Header1
  displayLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Mobile/Header2
  displayMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Mobile/Header3
  displaySmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Mobile/Header4
  headlineMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Mobile/Text Body
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: Color(0xFF626280),
  ),

  ///Mobile/Additional
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Mobile/Additional2
  titleMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: Color(0xFF626280),
  ),

  ///Desktop/Additional
  titleSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: Color(0xFF626280),
  ),
  labelMedium: TextStyle(
    color: Color(0xffA5ADC0),
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.2,
  ),
);
