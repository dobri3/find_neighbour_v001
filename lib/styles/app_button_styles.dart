import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {

  static Widget primaryButtonWithShadow({
    required VoidCallback onPressed,
    required String text,
    double width = 350,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.baseBright,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(text, style: AppTextStyles.buttonLarge),
      ),
    );
  }

  static ButtonStyle primaryMedium = ElevatedButton.styleFrom(
  backgroundColor: AppColors.baseBright,
  foregroundColor: AppColors.textBase,
  elevation: 5, 
  minimumSize: const Size(100, 40),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: BorderSide(
      color: AppColors.textBase.withOpacity(0.3),
      width: 1.0,
    ),
  ),
);

  static ButtonStyle primarySmall = ElevatedButton.styleFrom(
    backgroundColor: AppColors.baseBright,
    minimumSize: const Size(80, 32),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Secondary Button Style
  static ButtonStyle secondaryLarge = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.white,
    minimumSize: const Size(350, 50),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: AppColors.white, width: 2),
    ),
  );

  static ButtonStyle tealOutlinedButton(Size minSize) =>
      OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.teal,
        minimumSize: minSize,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.teal, width: 2),
        ),
      );

  static ButtonStyle tealFiledButton(Size minSize) => OutlinedButton.styleFrom(
        // backgroundColor: AppColors.teal,
        backgroundColor: AppColors.baseBright,
        foregroundColor: AppColors.white,
        minimumSize: minSize,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.white, width: 2),
        ),
      );

  // Text Button Style
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: AppColors.teal,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static ButtonStyle authButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.baseBright,
    foregroundColor: AppColors.textBase,
    elevation: 0,
    side: const BorderSide(color: AppColors.blueDark, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    minimumSize: const Size(double.infinity, 56),
  );

  static Widget socialButton({
    required VoidCallback onPressed,
    required String text,
    required Widget icon,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: authButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, size: 28, color: AppColors.textBase,),
            icon,
            const SizedBox(width: 12),
            Text(text, style: AppTextStyles.buttonText),
          ],
        ),
      ),
    );
  }

  static ButtonStyle primaryLarge = ElevatedButton.styleFrom(
    minimumSize: const Size(200, 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    foregroundColor: AppColors.textBase,
    backgroundColor: AppColors.baseBright,
  );
}

