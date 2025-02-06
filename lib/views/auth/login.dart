import 'package:aclub/views/home/persistent_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'reset.dart';
import 'signup.dart';


class SimpleLoginScreen extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, super.key});

  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String email, password, username;
  String? emailError, passwordError, usernameError;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    username = '';
  }

  void _resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      usernameError = null;
    });
  }
  bool isPasswordStrong(String password) {
    return password.length >= 8 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
  }

  bool _validateInputs() {
    _resetErrorText();
    bool isValid = true;

    if (username.isEmpty) {
      setState(() => usernameError = 'Please enter a username');
      isValid = false;
    }

    if (email.isEmpty ||
        !RegExp(r'^[\w\.-]+@(gmail\.com|aec\.edu\.in|acoe\.edu\.in|acet\.edu\.in|outlook\.com)$').hasMatch(email)) {
      setState(() => emailError = 'Enter a valid email');
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() => passwordError = 'Please enter a password');
      isValid = false;
    }

    return isValid;
  }

  void _submit() async {
    if (_validateInputs()) {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        widget.onSubmitted?.call(email, password);

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SimpleRegisterScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );

        // UserState().setUserInfo(email, username);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)], // Same gradient as in register screen
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Image.asset(
                'assets/logo/AU.png', // New logo image
                height: 100,
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'Welcome,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue!',
                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(height: screenHeight * 0.08),
              _buildTextField(
                label: 'Username',
                errorText: usernameError,
                onChanged: (value) => setState(() => username = value),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                label: 'Email',
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => setState(() => email = value),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                label: 'Password',
                errorText: passwordError,
                obscureText: true,
                onSubmitted: (_) => _submit(),
                onChanged: (value) => setState(() => password = value),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPassword()),
                  ),
                  child: const Text('Forgot Password?', style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildLoginButton(),
              SizedBox(height: screenHeight * 0.04),
              _buildSignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? errorText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }


Widget _buildLoginButton() {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepOrange, // Button color same as in register screen
      padding: const EdgeInsets.symmetric(vertical: 16.0),
    ),
    child: const Text(
      'Log In',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  );
}


  Widget _buildSignUpText() {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SimpleRegisterScreen()),
      ),
      child: RichText(
        text: const TextSpan(
          text: "I'm a new user, ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold), // Same sign-up text color
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'homescreeno.dart'; // Ensure correct import
// import 'widgets.dart';
// import 'signup.dart'; // Import the registration screen
// import 'user_state.dart';
// import 'navbar1.dart'; // Ensure correct import
//
// class SimpleLoginScreen extends StatefulWidget {
//   final Function(String? emailOrUsername, String? password)? onSubmitted;
//
//   const SimpleLoginScreen({this.onSubmitted, Key? key}) : super(key: key);
//
//   @override
//   State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
// }
//
// class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
//   late String emailOrUsername, password;
//   String? emailOrUsernameError, passwordError;
//   bool isEmail = false;
//
//   Function(String? emailOrUsername, String? password)? get onSubmitted =>
//       widget.onSubmitted;
//
//   @override
//   void initState() {
//     super.initState();
//     emailOrUsername = '';
//     password = '';
//     emailOrUsernameError = null;
//     passwordError = null;
//   }
//
//   void resetErrorText() {
//     setState(() {
//       emailOrUsernameError = null;
//       passwordError = null;
//     });
//   }
//
//   bool validate() {
//     resetErrorText();
//
//     // Regular expression to validate email
//     RegExp emailExp = RegExp(
//         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
//
//     bool isValid = true;
//
//     if (emailOrUsername.isEmpty) {
//       setState(() {
//         emailOrUsernameError = 'Please enter an email or username';
//       });
//       isValid = false;
//     } else if (emailExp.hasMatch(emailOrUsername)) {
//       // If input matches the email format, set it as an email
//       isEmail = true;
//     } else {
//       // Otherwise, treat it as a username
//       isEmail = false;
//     }
//
//     if (password.isEmpty) {
//       setState(() {
//         passwordError = 'Please enter a password';
//       });
//       isValid = false;
//     }
//
//     return isValid;
//   }
//
//   void submit() {
//     if (validate()) {
//       if (onSubmitted != null) {
//         // Update the global user state
//         UserState().setUserInfo(emailOrUsername, isEmail ? '' : emailOrUsername);
//         onSubmitted!(emailOrUsername, password);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MyHomePage(), // Ensure correct class name
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Stack(
//           children: [
//             ListView(
//               children: [
//                 SizedBox(height: screenHeight * .1), // Adjusted for iPhone 13 Pro Max
//                 const Text(
//                   'Welcome,',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * .01),
//                 Text(
//                   'Sign in to continue!',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black.withOpacity(.6),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * .08),
//                 InputField(
//                   onChanged: (value) {
//                     setState(() {
//                       emailOrUsername = value;
//                     });
//                   },
//                   labelText: 'Email or Username',
//                   errorText: emailOrUsernameError,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   autoFocus: true,
//                 ),
//                 SizedBox(height: screenHeight * .02),
//                 InputField(
//                   onChanged: (value) {
//                     setState(() {
//                       password = value;
//                     });
//                   },
//                   onSubmitted: (val) => submit(),
//                   labelText: 'Password',
//                   errorText: passwordError,
//                   obscureText: true,
//                   textInputAction: TextInputAction.done,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ForgotPassword(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * .05),
//                 ElevatedButton(
//                   onPressed: submit,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent, // Use backgroundColor instead of primary
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   ),
//                   child: const Text(
//                     'Log In',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * .1),
//                 TextButton(
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SimpleRegisterScreen(),
//                     ),
//                   ),
//                   child: RichText(
//                     text: const TextSpan(
//                       text: "I'm a new user, ",
//                       style: TextStyle(color: Colors.black),
//                       children: [
//                         TextSpan(
//                           text: 'Sign Up',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
