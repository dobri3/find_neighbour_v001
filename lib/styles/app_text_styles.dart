import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppRichTextStyles {
  static RichText logoText() {
    return RichText(
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Ищу',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: 'Соседа',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff6A999E),
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextStyles {
  // Home Page Heading
  static const TextStyle homePageHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.lightCyan,
  );

  static const TextStyle smallHeaderBold = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle smallSecondary = TextStyle(
    color: const Color(0xff6A999E),
    fontWeight: FontWeight.bold,
  );

  // Large Headings
  static const TextStyle largeHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle largeHeadingWhite = TextStyle(
    fontFamily: "Inter",
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle mediumHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 165, 237, 245),
  );

  // Small White Text
  static const TextStyle whiteSmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.white,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: "Inter",
    fontSize: 17,
    color: AppColors.white,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.white,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.white,
  );

  // Button Text Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: "Inter",
    fontSize: 17,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle neighbourName = TextStyle(
    fontFamily: "Inter",
    fontSize: 24,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle neighbourDetail = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.teal,
  );

  static const TextStyle neighbourDescription = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.lightText,
  );

  static const TextStyle neighbourLabel = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.teal,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle authTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 28,
    color: AppColors.white,
  );

  static const TextStyle authSubtitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    color: AppColors.gray500,
  );

  static const TextStyle authFooter = TextStyle(
    fontFamily: "Inter",
    fontSize: 12,
    color: AppColors.gray400,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    color: AppColors.lightGray,
  );

  static const TextStyle profileTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle profileName = TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.white,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.teal,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.white,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.gray500,
  );
}
