// import 'package:find_neighbour_v001/styles/app_colors.dart';
// import 'package:flutter/material.dart';

// class GradientText extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//   final Gradient gradient;
//   final TextAlign textAlign;
//   final int? maxLines;

//   const GradientText(
//     this.text, {
//     super.key,
//     required this.style,
//     required this.gradient,
//     this.textAlign = TextAlign.left,
//     this.maxLines,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) {
//         return gradient.createShader(
//           Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//         );
//       },
//       child: Text(
//         text,
//         style: style.copyWith(
//           color: Colors.white, // обязательно, иначе не видно
//         ),
//         textAlign: textAlign,
//         maxLines: maxLines,
//         softWrap: true,
//       ),
//     );
//   }
// }



// class AppTextStyles {
//   // Home Page Heading
//   static const Text logo = Text(
//             'ИщуСоседа',
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textBase,
//               decorationColor: AppColors.textBase,
//               decoration: TextDecoration.underline,
//             ),
//   );

//   static const TextStyle homePageHeading = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 32,
//     fontWeight: FontWeight.bold,
//     color: AppColors.textBase,
//   );

//   static const TextStyle smallHeaderBold = TextStyle(
//     color: AppColors.textBase,
//     fontWeight: FontWeight.bold,
//     fontSize: 20,
//   );

//   static const TextStyle smallSecondary = TextStyle(
//     color: AppColors.textBase,
//     fontWeight: FontWeight.bold,
//   );

//   // Large Headings
//   static const TextStyle largeHeading = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 48,
//     fontWeight: FontWeight.bold,
//     color: AppColors.textBase,
//   );

//   static const TextStyle largeHeadingWhite = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 48,
//     fontWeight: FontWeight.bold,
//     color: AppColors.textBase,
//   );

//   static const TextStyle mediumHeading = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 64,
//     fontWeight: FontWeight.bold,
//     color: AppColors.textBase,
//   );

//   // Small White Text
  // static const TextStyle whiteSmall = TextStyle(
  //   fontFamily: "Inter",
  //   fontSize: 15,
  //   color: AppColors.textBase,
  // );

//   // Body Text
//   static const TextStyle bodyLarge = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 17,
//     color: AppColors.textBase,
//   );

//   static const TextStyle bodyMedium = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 15,
//     color: AppColors.textBase,
//   );

//   static const TextStyle bodySmall = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 14,
//     color: AppColors.textBase,
//   );

//   // Button Text Styles
//   static const TextStyle buttonLarge = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 17,
//     color: AppColors.textBase,
//     fontWeight: FontWeight.w600,
//   );

//   static const TextStyle buttonMedium = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 15,
//     color: AppColors.textBase,
//     fontWeight: FontWeight.w500,
//   );

//   static const TextStyle buttonSmall = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 14,
//     color: AppColors.textBase,
//     fontWeight: FontWeight.w500,
//   );

//   static const TextStyle neighbourName = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 20,
//     color: AppColors.textBase,
//     fontWeight: FontWeight.w600,
//   );

//   static const TextStyle neighbourDetail = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 14,
//     color: AppColors.textBase,
//   );

//   static const TextStyle neighbourDescription = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 14,
//     color: AppColors.textBase,
//   );

//   static const TextStyle neighbourLabel = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 14,
//     color: AppColors.textBase,
//     fontWeight: FontWeight.w500,
//   );

//   static const TextStyle authTitle = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 28,
//     color: AppColors.textBase,
//   );

//   static const TextStyle authSubtitle = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 16,
//     color: AppColors.textBase,
//   );

//   static const TextStyle authFooter = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 12,
//     color: AppColors.textBase,
//   );

//   static const TextStyle buttonText = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 16,
//     color: AppColors.textBase,
//   );

//   static const TextStyle profileTitle = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 32,
//     fontWeight: FontWeight.bold,
//     color: AppColors.textBase,
//   );

//   static const TextStyle profileName = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 20,
//     fontWeight: FontWeight.w300,
//     color: AppColors.textBase,
//   );

//   static const TextStyle sectionTitle = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 20,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textBase,
//   );

//   static const TextStyle inputLabel = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 16,
//     fontWeight: FontWeight.w100,
//     color: AppColors.textBase,
//   );

//   static const TextStyle inputHint = TextStyle(
//     fontFamily: "Inter",
//     fontSize: 16,
//     fontWeight: FontWeight.w100,
//     color: AppColors.textBase,
//   );
// }


import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';

class AppTextStyles {
//   static TextStyle logo(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 750;
//     return TextStyle(
//       fontSize: isMobile ? 24 : 30,
//       fontWeight: FontWeight.bold,
//       color: AppColors.textBase,
//       decoration: TextDecoration.underline,
//       decorationColor: AppColors.textBase,
//     );
//   }
static Widget logo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;

    return Text(
      'ИщуСоседа',
      style: TextStyle(
        fontSize: isMobile ? 24 : 30,
        fontWeight: FontWeight.bold,
        color: AppColors.textBase,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.textBase,
      ),
    );
  }


  static TextStyle largeHeading(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isMobile ? 32 : 48,
      fontWeight: FontWeight.bold,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle mediumHeading(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    return TextStyle(
      fontSize: isMobile ? 32 : 64,
      fontWeight: FontWeight.bold,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
    static TextStyle buttonLarge(BuildContext context) {

      return TextStyle(
    fontFamily: "Inter",
    fontSize: 17,
    color: AppColors.textBase,
    fontWeight: FontWeight.w600,);
    }

  static TextStyle buttonText(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    double fontSize;
    if (isSmall) {
      fontSize = isMobile ? 12 : 14;
    } else {
      fontSize = isMobile ? 14 : 16;
    }
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle neighbourDescription(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isMobile ? 12 : 14,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle neighbourDetail(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isMobile ? 12 : 14,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle profileTitle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isMobile ? 24 : 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle bodyText(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 12 : 14)
          : (isMobile ? 14 : 16),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

  static TextStyle whiteSmall(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 12 : 15)
          : (isMobile ? 14 : 16),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }

static TextStyle buttonSmall(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 10 : 12)
          : (isMobile ? 12 : 14),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
    static const TextStyle smallSecondary = TextStyle(
    color: AppColors.textBase,
    fontWeight: FontWeight.bold,
  );
static TextStyle smallHeaderBold(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isSmall
          ? (isMobile ? 16 : 18)
          : (isMobile ? 18 : 20),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
static TextStyle neighbourName(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: isSmall
          ? (isMobile ? 16 : 18)
          : (isMobile ? 18 : 20),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
static TextStyle inputLabel(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: isSmall
          ? (isMobile ? 12 : 14)
          : (isMobile ? 14 : 16),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
static TextStyle authTitle(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: isSmall
          ? (isMobile ? 22 : 24)
          : (isMobile ? 26 : 28),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
static TextStyle authSubtitle(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 12 : 14)
          : (isMobile ? 14 : 16),
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
    static const TextStyle authFooter = TextStyle(
    fontFamily: "Inter",
    fontSize: 12,
    color: AppColors.textBase,
  );
static TextStyle sectionTitle(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 16 : 18)
          : (isMobile ? 18 : 20),
      color: AppColors.textBase,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
    );
  }
static TextStyle bodyLarge(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 12 : 15)
          : (isMobile ? 15 : 17),
      color: AppColors.textBase,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
    );
  }
static TextStyle largeHeadingWhite(BuildContext context, {bool isSmall = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: isSmall
          ? (isMobile ? 38 : 43)
          : (isMobile ? 43 : 48),
      color: AppColors.textBase,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
    );
  }

   // Text(
                                //   "$_name $_surname",
                                //   style: const TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w300,
                                //     color: AppColors.textBase,
                                //   ),
  static TextStyle profileName(BuildContext context, {bool isSmall = false}) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final isMobile = screenWidth < 750;
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: AppColors.textBase,
      fontFamily: "Inter",
    );
  }
}
