import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';

class AppContainerStyles {
  // Card Style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(12),
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
    // color: AppColors.black,
    // gradient: LinearGradient(colors: [Color(0xFF32668D).withOpacity(0.20), Color(0xFF131718).withOpacity(0.80)],
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight),
    color: AppColors.baseBright,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.blueDark),
  );

  static BoxDecoration photoContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
              color: Color(0xFF6A999E), 
              width: 2.0,        
            ),
  );

  static BoxDecoration authCard = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppColors.color1,
  );

  static BoxDecoration profileCard = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(color: AppColors.borderTeal, width: 1),
    color: AppColors.white,
  );

  static BoxDecoration sectionContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    // color: AppColors.transparentBlue,
    color: AppColors.baseBright.withOpacity(0.5),
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
