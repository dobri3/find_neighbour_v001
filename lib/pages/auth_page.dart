// ignore: deprecated_member_use
import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_button_styles.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:flutter/material.dart';
import 'package:find_neighbour_v001/api/api.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:find_neighbour_v001/pages/home_page.dart';
// import '../widgets/toast_notification.dart';

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
    backgroundColor: AppColors.darkBlue,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                height: 600,
                width: 500,
                padding: const EdgeInsets.all(15.0),
                decoration: AppContainerStyles.authCard,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    const Icon(
                      Icons.people_alt_rounded,
                      size: 80,
                      color: AppColors.indigo,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Title
                    const Text(
                      "Добро пожаловать!",
                      style: AppTextStyles.authTitle,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Subtitle
                    const Text(
                      "Войдите через Google, чтобы продолжить",
                      style: AppTextStyles.authSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Google Button
                    AppButtonStyles.socialButton(
                      onPressed: () async {
                        // launchUrl(Uri.parse(await ApiService.googleAuthURL()));
                         final url = await ApiService.googleAuthURL();
                          // print("GOOGLE URL = $url");
                          html.window.location.href = url;
                      },
                      text: "Войти через Google",
                      icon: Icons.g_mobiledata,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Yandex Button
                    AppButtonStyles.socialButton(
                      onPressed: () async {
                        // launchUrl(Uri.parse(await ApiService.googleAuthURL()));
                         final url = await ApiService.yandexAuthURL();
                          html.window.location.href = url;
                      },
                      text: "Войти через Yandex",
                      icon: Icons.g_mobiledata,
                    ),
                    
                    const SizedBox(height: 24),
                    const SizedBox(height: 24),
                    
                    // Footer text
                    const Text(
                      "Продолжая, вы соглашаетесь с нашими\nУсловиями использования и Политикой конфиденциальности",
                      style: AppTextStyles.authFooter,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  
}
