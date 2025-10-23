import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      backgroundColor: const Color(0xFF1C2B38),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF131718),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 0),
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
                          color: Color(0xFF6366F1),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Добро пожаловать!",
                          style: TextStyle(
                            fontSize: 28,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Войдите через Google, чтобы продолжить",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            color: Color(0xFF6B7280),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        //  _buildGoogleButton(),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            // Google Button
                            // onPressed: _isLoading ? null : _signInWithGoogle,
                            onPressed: () async {
                              launchUrl(
                                  Uri.parse(await ApiService.googleAuthURL()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F2937),
                              foregroundColor: const Color(0xFF32658D),
                              elevation: 0,
                              side: const BorderSide(
                                  color: Color(0xFF32658D), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.g_mobiledata,
                                    size: 28,
                                    color: Color.fromARGB(255, 222, 222, 222)),
                                SizedBox(width: 12),
                                Text(
                                  "Войти через Google",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                    color: Color.fromARGB(255, 222, 222, 222),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            // onPressed: _isLoading ? null : _signInWithGoogle,
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F2937),
                              foregroundColor: const Color(0xFF32658D),
                              elevation: 0,
                              side: const BorderSide(
                                  color: Color(0xFF32658D), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.g_mobiledata,
                                    size: 28,
                                    color: Color.fromARGB(255, 222, 222, 222)),
                                SizedBox(width: 12),
                                Text(
                                  "Войти через Yandex",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                    color: Color.fromARGB(255, 222, 222, 222),
                                  ),
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
                      ]),
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
