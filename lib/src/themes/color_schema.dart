import 'package:flutter/material.dart';
import 'color_palettes.dart';

class SaintColors {
  static const Color primary = WarmColors.orange;
  static const Color secondary = WarmColors.yellow;
  static const Color background = WarmColors.deepBlue;
  static const Color foreground = WarmColors.cream;
  static const Color surface = WarmColors.marineBlue;
  static const Color contrast = WarmColors.gold;

  static const Color error = WarmColors.red;
  static const Color success = WarmColors.green;
}

ColorScheme getColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    seedColor: SaintColors.primary,
    brightness: brightness,
    primary: SaintColors.primary,
    onPrimary: SaintColors.background,
    secondary: SaintColors.secondary,
    onSecondary: SaintColors.contrast,
    surface: SaintColors.secondary,
    onSurface: SaintColors.contrast,
    error: SaintColors.error,
    onError: Colors.white,
  );
}