// import 'package:flutter/material.dart';

// // is loading для чего, можно ли избежать, не сломает ли навигацию?
// // переписать для container


// class PrimaryButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final bool isLoading;
//   final double? width;
//   final Color? backgroundColor;

//   const PrimaryButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.isLoading = false,
//     this.width,
//     this.backgroundColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width ?? double.infinity,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation(Colors.white),
//                 ),
//               )
//             : Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {
  // Primary Button Style
  // static ButtonStyle primaryLarge = ElevatedButton.styleFrom(
  //   backgroundColor: AppColors.teal,
  //   minimumSize: const Size(350, 50),
  //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  //   elevation: 4,
  //   shadowColor: Colors.black.withOpacity(0.3),
  // );

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
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
    backgroundColor: AppColors.teal,
    minimumSize: const Size(100, 40),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
  
  static ButtonStyle primarySmall = ElevatedButton.styleFrom(
    backgroundColor: AppColors.teal,
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
  
  // Text Button Style
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: AppColors.teal,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static ButtonStyle authButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.gray700,
    foregroundColor: AppColors.blueDark,
    elevation: 0,
    side: const BorderSide(color: AppColors.blueDark, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    minimumSize: const Size(double.infinity, 56),
  );
  
  static Widget socialButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: authButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppColors.lightGray),
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
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.teal,
  );
}