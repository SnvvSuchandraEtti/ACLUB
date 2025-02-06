// import 'package:flutter/material.dart';
// import 'package:aclub/auth//login.dart';
//
// class LoginProvider extends ChangeNotifier {
//   String email = '';
//   String password = '';
//   String username = '';
//   String? emailError;
//   String? passwordError;
//   String? usernameError;
//   bool isSubmitting = false;
//
//   void resetErrorText() {
//     emailError = null;
//     passwordError = null;
//     usernameError = null;
//     notifyListeners();
//   }
//
//   bool isPasswordStrong(String password) {
//     return password.length >= 8 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
//   }
//
//   bool validateInputs() {
//     resetErrorText();
//     bool isValid = true;
//
//     if (username.isEmpty) {
//       usernameError = 'Please enter a username';
//       isValid = false;
//     }
//
//     if (email.isEmpty ||
//         !RegExp(r'^[\w\.-]+@(gmail\.com|aec\.edu\.in|outlook\.com)$').hasMatch(email)) {
//       emailError = 'Enter a valid email ending with @gmail.com, @aec.edu.in, or @outlook.com';
//       isValid = false;
//     }
//
//     if (password.isEmpty) {
//       passwordError = 'Please enter a password';
//       isValid = false;
//     }
//
//     notifyListeners();
//     return isValid;
//   }
//
//   Future<void> submit(Function(String? email, String? password)? onSubmitted, BuildContext context) async {
//     if (validateInputs()) {
//       isSubmitting = true;
//       notifyListeners();
//
//       await Future.delayed(const Duration(seconds: 1));
//
//       if (onSubmitted != null) {
//         onSubmitted(email, password);
//       }
//
//       isSubmitting = false;
//       notifyListeners();
//
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => SimpleLoginScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(0.0, 1.0);
//             const end = Offset.zero;
//             const curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(
//               position: offsetAnimation,
//               child: FadeTransition(
//                 opacity: animation,
//                 child: child,
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }
// }
