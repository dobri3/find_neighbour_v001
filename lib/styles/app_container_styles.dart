import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

class AppContainerStyles {
  // Card Style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Section Border
  static BoxDecoration sectionBorder = const BoxDecoration(
    border: BorderDirectional(
      bottom: BorderSide(
        color: AppColors.lightCyan,
        width: 2,
      ),
    ),
  );

  static BoxDecoration neighbourCard = BoxDecoration(
    color: AppColors.black,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.blueDark),
  );

  static BoxDecoration photoContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration authCard = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppColors.midnight,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 0),
      ),
    ],
  );

  static BoxDecoration profileCard = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.33),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 0),
      ),
    ],
    border: Border.all(color: AppColors.borderTeal, width: 1),
    color: AppColors.darkCard,
  );

  static BoxDecoration sectionContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: AppColors.transparentBlue,
    border: Border.all(color: AppColors.borderTeal, width: 1),
  );

  static InputDecoration textInput(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.inputHint,
        filled: true,
        fillColor: AppColors.transparentBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.borderTeal,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.teal,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.borderBlue,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      );
  // static BoxDecoration gradientOverlay = BoxDecoration(
  //   borderRadius: BorderRadius.circular(20),
  //   gradient: const LinearGradient(
  //     begin: Alignment.bottomRight,
  //     colors: [
  //       Colors.black.withOpacity(0.8),
  //       Colors.black.withOpacity(0.2),
  //     ],
  //   ),
  // );
}
