import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {
  // Primary button style
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonPrimary,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    minimumSize: const Size(200, 60),
  );
  
  // Secondary button style
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonSecondary,
    foregroundColor: AppColors.primaryBlue,
    elevation: 0,
    side: const BorderSide(color: AppColors.primaryBlue, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    minimumSize: const Size(double.infinity, 56),
  );
  
  // Small primary button style
  static ButtonStyle smallPrimaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonPrimary,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    minimumSize: const Size(100, 40),
  );
  
  // Text button style
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: AppColors.textPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
  
  // Icon button style
  static ButtonStyle iconButton = IconButton.styleFrom(
    foregroundColor: AppColors.textPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  // Outlined button style
  static ButtonStyle outlinedButton = OutlinedButton.styleFrom(
    foregroundColor: AppColors.textPrimary,
    side: const BorderSide(color: AppColors.borderPrimary, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    minimumSize: const Size(double.infinity, 48),
  );
  
  // Floating action button theme
  static FloatingActionButtonThemeData fabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.buttonPrimary,
    foregroundColor: AppColors.textPrimary,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
