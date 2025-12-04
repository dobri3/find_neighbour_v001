import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;
  final int? maxLines;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.gradient,
    this.textAlign = TextAlign.left,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white, // обязательно, иначе не видно
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: true,
      ),
    );
  }
}



class AppTextStyles {
  // Home Page Heading
  static const Text logo = Text(
            'ИщуСоседа',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.textBase,
              decorationColor: AppColors.textBase,
              decoration: TextDecoration.underline,
            ),
  );

  static const TextStyle homePageHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textBase,
  );

  static const TextStyle smallHeaderBold = TextStyle(
    color: AppColors.textBase,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle smallSecondary = TextStyle(
    color: AppColors.textBase,
    fontWeight: FontWeight.bold,
  );

  // Large Headings
  static const TextStyle largeHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textBase,
  );

  static const TextStyle largeHeadingWhite = TextStyle(
    fontFamily: "Inter",
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textBase,
  );

  static const TextStyle mediumHeading = TextStyle(
    fontFamily: "Inter",
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: AppColors.textBase,
  );

  // Small White Text
  static const TextStyle whiteSmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.textBase,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: "Inter",
    fontSize: 17,
    color: AppColors.textBase,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.textBase,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.textBase,
  );

  // Button Text Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: "Inter",
    fontSize: 17,
    color: AppColors.textBase,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: "Inter",
    fontSize: 15,
    color: AppColors.textBase,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.textBase,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle neighbourName = TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    color: AppColors.textBase,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle neighbourDetail = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.textBase,
  );

  static const TextStyle neighbourDescription = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.textBase,
  );

  static const TextStyle neighbourLabel = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    color: AppColors.textBase,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle authTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 28,
    color: AppColors.textBase,
  );

  static const TextStyle authSubtitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    color: AppColors.textBase,
  );

  static const TextStyle authFooter = TextStyle(
    fontFamily: "Inter",
    fontSize: 12,
    color: AppColors.textBase,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    color: AppColors.textBase,
  );

  static const TextStyle profileTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textBase,
  );

  static const TextStyle profileName = TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.textBase,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textBase,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.textBase,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.textBase,
  );
}
