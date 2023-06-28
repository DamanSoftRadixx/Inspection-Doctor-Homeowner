import 'package:flutter/material.dart';

class AppColorPalette {
  final MaterialColor primarySwatch;
  final MaterialColor secondarySwatch;
  final MaterialColor additionalSwatch1;
  final MaterialColor whiteColorPrimary;
  final MaterialColor stroke;
  final Color transparentColor;
  final Color backgroundColor;
  final Color redColor;

  AppColorPalette({
    required this.primarySwatch,
    required this.secondarySwatch,
    required this.additionalSwatch1,
    required this.whiteColorPrimary,
    required this.stroke,
    required this.transparentColor,
    required this.backgroundColor,
    required this.redColor,
  });
}

AppColorPalette lightColorPalette = AppColorPalette(
  primarySwatch: const MaterialColor(800, {
    900: Color(0xFF0060F7),
    800: Color(0xFF1A4563),
    700: Color(0xFF757F8E),
  }),
  secondarySwatch: const MaterialColor(
      600, {900: Color(0xFF30AC8A), 800: Color(0xFFECFCFA)}),
  additionalSwatch1: const MaterialColor(800, {
    900: Color(0xFF626280),
    800: Color(0xFFD7D4D7),
    700: Color(0xFF867D88),
    600: Color(0xFFFF7446),
    500: Color(0xFFFBFBFB),
    400: Color(0xFFF5F4F5)
  }),
  whiteColorPrimary: const MaterialColor(900, {
    900: Color(0xFFFFFFFF),
    800: Color(0xFFFAFAFA),
    700: Color(0xFFF5F5F5),
    600: Color(0xFFF9F9F9),
  }),
  transparentColor: Colors.transparent,
  redColor: Colors.red,
  backgroundColor: const Color(0xFFE5E5E5),
  stroke: const MaterialColor(800, {
    900: Color(0xFF0060F7),
    800: Color(0xFF1A4563),
    700: Color(0xFF757F8E),
  }),
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
