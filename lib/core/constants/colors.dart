import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient
  static const Color primaryStart = Color(0xFFff6b6b); // Coral Red
  static const Color primaryEnd = Color(0xFFee5a6f); // Deep Coral
  static const Color primaryDark = Color(0xFFc44569); // Burgundy

  // Accent
  static const Color accentPink = Color(0xFFffc0cb); // Light Pink
  static const Color accentYellow = Color(0xFFfef6e4); // Cream

  // Backgrounds
  static const Color bgLight = Color(0xFFfff5f5); // Pale Pink
  static const Color sidebarStart = Color(0xFFfef6e4);
  static const Color sidebarEnd = Color(0xFFf8e5c1);

  // Neutrals
  static const Color textDark = Color(0xFFc44569);
  static const Color textMedium = Color(0xFF8b6914); // Brown
  static const Color borderLight = Color(0xFFe8d4a8); // Tan
  static const Color borderMedium = Color(0xFFffc0cb); // Pink

  // Semantic
  static const Color success = Color(0xFF22c55e);
  static const Color error = Color(0xFFef4444);
  static const Color warning = Color(0xFFf59e0b);
  static const Color info = Color(0xFF3b82f6);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sidebarGradient = LinearGradient(
    colors: [sidebarStart, sidebarEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient bgLightGradient = LinearGradient(
    colors: [bgLight, Color(0xFFffe8e8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
