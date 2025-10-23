import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class AppTextStyles {
  // Heading styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w100,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  static const TextStyle headingLargeBold = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textAccent,
    fontFamily: "Inter",
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  // Body text styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  // Secondary text styles
  static const TextStyle secondaryLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textAccent,
    fontFamily: "Inter",
  );
  
  static const TextStyle secondaryMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: "Inter",
  );
  
  // Label styles
  static const TextStyle labelMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  // Button text styles
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: "Inter",
  );
  
  // static const TextStyle buttonSecondary = TextStyle(
  //   fontSize: 16,
  //   fontWeight: FontWeight.normal,
  //   color: AppColors.buttonText,
  //   fontFamily: "Inter",
  // );
  
  // static const TextStyle buttonSmall = TextStyle(
  //   fontSize: 15,
  //   fontWeight: FontWeight.normal,
  //   color: AppColors.textPrimary,
  //   fontFamily: "Inter",
  // );
}
