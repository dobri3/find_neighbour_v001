import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/routing/app_router.dart';
import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/app_textstyles.dart';
import '../styles/app_buttonstyles.dart';


@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {

  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: ['email', 'profile'],
  // );

  // bool _isLoading = false;

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (!mounted) return;
  //     if (googleUser != null) {
  //       ToastNotification.showSuccess(
  //         context,
  //         'Успешный вход через Google: ${googleUser.email}',
  //       );
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (_) => const HomePage()),
  //       );
  //     }
  //   } catch (error) {
  //     if (mounted) {
  //       ToastNotification.showError(
  //         context,
  //         'Ошибка входа через Google: $error',
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Center(
                 child: Container(height: 600, width: 500, 
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                 color: AppColors.backgroundCard,
                 boxShadow: const [
                    BoxShadow(
                     color: AppColors.shadowBlack,
                     blurRadius: 20,
                     spreadRadius: 2,
                     offset: Offset(0, 0),
                   ),
                 ],
                ),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const Icon(
                  Icons.people_alt_rounded,
                  size: 80,
                  color: AppColors.primaryPurple,
                               ),
                 const SizedBox(height: 24),
                 const Text(
                  "Добро пожаловать!",
                  style: AppTextStyles.headingSmall,
                  textAlign: TextAlign.center,
                               ),
                 const SizedBox(height: 8),
                 const Text(
                  "Войдите через Google, чтобы продолжить",
                  style: AppTextStyles.secondaryMedium,
                  textAlign: TextAlign.center,
                               ),
                 const SizedBox(height: 48),
                               //  _buildGoogleButton(),
                               SizedBox(
                       height: 56,
                       child: ElevatedButton(
                         // onPressed: _isLoading ? null : _signInWithGoogle,
                         onPressed: () {
                          context.router.push(const UserProfileRoute());
                         },
                         style: AppButtonStyles.secondaryButton,
                         child: const Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.g_mobiledata, size: 28, color: AppColors.buttonText),
                             SizedBox(width: 12),
                             Text(
                               "Войти через Google",
                               style: AppTextStyles.buttonPrimary,
                             ),
                           ],
                         ),
                       ),
                     ),
                     const SizedBox(height: 24,),
                     SizedBox(
                       height: 56,
                       child: ElevatedButton(
                         // onPressed: _isLoading ? null : _signInWithGoogle,
                         onPressed: () {
                          context.router.push(const UserProfileRoute());
                         },
                         style: AppButtonStyles.secondaryButton,
                         child: const Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.g_mobiledata, size: 28, color: AppColors.buttonText),
                             SizedBox(width: 12),
                             Text(
                               "Войти через Yandex",
                               style: AppTextStyles.buttonPrimary,
                             ),
                           ],
                         ),
                       ),
                     ),
                               const SizedBox(height: 24),
                               const SizedBox(height: 24),
                               const Text(
                  "Продолжая, вы соглашаетесь с нашими\nУсловиями использования и Политикой конфиденциальности",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Inter",
                    color: Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                               ),
                  ]
                               ),
                               ),
               ),
              
              
              

              

              // if (_isLoading)
              //   const Center(
              //     child: CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
              //     ),
              //   ),

              
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildGoogleButton() {
  //   return SizedBox(
  //     height: 56,
  //     child: ElevatedButton(
  //       // onPressed: _isLoading ? null : _signInWithGoogle,
  //       onPressed: () {},
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.white,
  //         foregroundColor: const Color(0xFF1F2937),
  //         elevation: 0,
  //         side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(Icons.g_mobiledata, size: 28, color: Color(0xFF1F2937)),
  //           SizedBox(width: 12),
  //           Text(
  //             "Войти через Google",
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               fontFamily: "Inter",
  //               color: Color(0xFF1F2937),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

