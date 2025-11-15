import 'package:flutter/material.dart';

class AppColors {
  // Light Theme
  static const Color primaryLight = Color(0xFF6C5CE7);
  static const Color secondaryLight = Color(0xFF00B894);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFFF6B6B);
  static const Color textPrimaryLight = Color(0xFF2D3436);
  static const Color textSecondaryLight = Color(0xFF636E72);
  
  // Dark Theme
  static const Color primaryDark = Color(0xFF6C5CE7);
  static const Color secondaryDark = Color(0xFF00B894);
  static const Color backgroundDark = Color(0xFF0D0D0D);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color errorDark = Color(0xFFFF6B6B);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB2BEC3);
  
  // Accent Colors
  static const Color income = Color(0xFF26DE81);
  static const Color expense = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFECA57);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient incomeGradient = LinearGradient(
    colors: [Color(0xFF26DE81), Color(0xFF20BF6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient expenseGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
