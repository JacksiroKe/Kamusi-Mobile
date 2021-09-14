import 'package:flutter/material.dart';
import 'app_colors.dart';

final asLightTheme = lightTheme();
final asDarkTheme = darkTheme();

ThemeData lightTheme() {
  const Color primaryColor = AppColors.primaryColor;
  const Color secondaryColor = AppColors.secondaryColor;
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: secondaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: AppColors.activeColor,
    splashColor: AppColors.splashColor,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: AppColors.errorColor,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    accentTextTheme: base.accentTextTheme,
  );
}

ThemeData darkTheme() {
  const Color primaryColor = Colors.grey;
  const Color secondaryColor = Colors.black;
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: AppColors.activeColor2,
    accentColor: secondaryColor,
    canvasColor: AppColors.baseColor2,
    scaffoldBackgroundColor: AppColors.baseColor2,
    backgroundColor: AppColors.baseColor2,
    errorColor: AppColors.errorColor,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    accentTextTheme: base.accentTextTheme,
  );
}
