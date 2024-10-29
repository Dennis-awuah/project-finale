import 'package:flutter/material.dart';

// Define constants for colors
class AppColors {
  static const Color primaryColor = Colors.blueAccent;
  static const Color accentColor = Colors.redAccent;
  static const Color backgroundColor = Color(0xFFEFEFEF); // Light grey
  static const Color textColor = Colors.black;
  static const Color inputFillColor = Colors.white;
  static const Color buttonColor = Colors.blueAccent;
  static const Color iconColor = Colors.white;
}

// Define constants for text styles
class AppTextStyles {
  static const TextStyle appBarTitleStyle = TextStyle(
    fontFamily: 'BlackOpsOne',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headlineStyle = TextStyle(
    fontFamily: 'BlackOpsOne',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.iconColor,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.primaryColor,
  );
}

// Define general app theme
ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    hintColor: AppColors.accentColor,

    // Define text themes
    textTheme: TextTheme(
      displayLarge: AppTextStyles.headlineStyle,
      bodyLarge: AppTextStyles.inputTextStyle,
      // Add more text styles as needed (headline2, subtitle1, etc.)
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFillColor,
      labelStyle: AppTextStyles.inputLabelStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.accentColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor, // Changed from 'primary' to 'backgroundColor'
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: AppTextStyles.buttonTextStyle,
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // Changed from 'primary' to 'foregroundColor'
        textStyle: AppTextStyles.linkTextStyle,
      ),
    ),

    // Icon theme
    iconTheme: IconThemeData(
      color: AppColors.iconColor,
    ),
  );
}
