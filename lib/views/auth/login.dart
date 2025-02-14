import 'package:aclub/login.dart';
import 'package:flutter/material.dart';
import 'authService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleRegisterScreen(),
    );
  }
}

class SimpleRegisterScreen extends StatefulWidget {
  const SimpleRegisterScreen({super.key});

  @override
  State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  final AuthService authService = AuthService();
  final TextEditingController firstcntrl = TextEditingController();
  final TextEditingController lastcntrl = TextEditingController();
  final TextEditingController rollcntrl = TextEditingController();
  final TextEditingController phonecntrl = TextEditingController();
  final TextEditingController passcntrl = TextEditingController();

  void register() async {
    final response = await authService.registerUser(
      firstcntrl.text.trim(),
      lastcntrl.text.trim(),
      rollcntrl.text.trim(),
      phonecntrl.text.trim(),
      passcntrl.text.trim(),
    );

    if (response.containsKey('status') && response['status'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Successfully registered")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? "Unknown error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)],
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
                'D:/pro/aclub/assets/logo/AU.png',
                height: 100,
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'Create Account,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started!',
                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildInputField(label: 'First Name', controller: firstcntrl),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Last Name', controller: lastcntrl),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Roll No', controller: rollcntrl, keyboardType: TextInputType.number),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Phone No', controller: phonecntrl, keyboardType: TextInputType.phone),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Password', controller: passcntrl, obscureText: true),
              SizedBox(height: screenHeight * 0.025),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        minimumSize: Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSignInText(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      ),
      child: RichText(
        text: const TextSpan(
          text: "I'm already a member, ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:aclub/views/home/persistent_bottom_navbar.dart';
// import 'package:flutter/material.dart';
// import 'reset.dart';
// import 'signup.dart';


// class SimpleLoginScreen extends StatefulWidget {
//   final Function(String? email, String? password)? onSubmitted;

//   const SimpleLoginScreen({this.onSubmitted, super.key});

//   @override
//   State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
// }

// class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
//   late String email, password, username;
//   String? emailError, passwordError, usernameError;

//   @override
//   void initState() {
//     super.initState();
//     email = '';
//     password = '';
//     username = '';
//   }

//   void _resetErrorText() {
//     setState(() {
//       emailError = null;
//       passwordError = null;
//       usernameError = null;
//     });
//   }
//   bool isPasswordStrong(String password) {
//     return password.length >= 8 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
//   }

//   bool _validateInputs() {
//     _resetErrorText();
//     bool isValid = true;

//     if (username.isEmpty) {
//       setState(() => usernameError = 'Please enter a username');
//       isValid = false;
//     }

//     if (email.isEmpty ||
//         !RegExp(r'^[\w\.-]+@(gmail\.com|aec\.edu\.in|acoe\.edu\.in|acet\.edu\.in|outlook\.com)$').hasMatch(email)) {
//       setState(() => emailError = 'Enter a valid email');
//       isValid = false;
//     }

//     if (password.isEmpty) {
//       setState(() => passwordError = 'Please enter a password');
//       isValid = false;
//     }

//     return isValid;
//   }

//   void _submit() async {
//     if (_validateInputs()) {
//       await Future.delayed(const Duration(seconds: 1));

//       if (mounted) {
//         widget.onSubmitted?.call(email, password);

//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) => SimpleRegisterScreen(),
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               const begin = Offset(0.0, 1.0);
//               const end = Offset.zero;
//               const curve = Curves.easeInOut;

//               var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//               var offsetAnimation = animation.drive(tween);

//               return SlideTransition(
//                 position: offsetAnimation,
//                 child: FadeTransition(
//                   opacity: animation,
//                   child: child,
//                 ),
//               );
//             },
//           ),
//         );

//         // UserState().setUserInfo(email, username);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)], // Same gradient as in register screen
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ListView(
//             children: [
//               SizedBox(height: screenHeight * 0.1),
//               Image.asset(
//                 'assets/logo/AU.png', // New logo image
//                 height: 100,
//               ),
//               SizedBox(height: screenHeight * 0.04),
//               const Text(
//                 'Welcome,',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign in to continue!',
//                 style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
//               ),
//               SizedBox(height: screenHeight * 0.08),
//               _buildTextField(
//                 label: 'Username',
//                 errorText: usernameError,
//                 onChanged: (value) => setState(() => username = value),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               _buildTextField(
//                 label: 'Email',
//                 errorText: emailError,
//                 keyboardType: TextInputType.emailAddress,
//                 onChanged: (value) => setState(() => email = value),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               _buildTextField(
//                 label: 'Password',
//                 errorText: passwordError,
//                 obscureText: true,
//                 onSubmitted: (_) => _submit(),
//                 onChanged: (value) => setState(() => password = value),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const ForgotPassword()),
//                   ),
//                   child: const Text('Forgot Password?', style: TextStyle(color: Colors.black)),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               _buildLoginButton(),
//               SizedBox(height: screenHeight * 0.04),
//               _buildSignUpText(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     String? errorText,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     TextInputAction textInputAction = TextInputAction.next,
//     void Function(String)? onChanged,
//     void Function(String)? onSubmitted,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         errorText: errorText,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       onChanged: onChanged,
//       onFieldSubmitted: onSubmitted,
//     );
//   }


// Widget _buildLoginButton() {
//   return ElevatedButton(
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => NavBar()),
//       );
//     },
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.deepOrange, // Button color same as in register screen
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//     ),
//     child: const Text(
//       'Log In',
//       style: TextStyle(fontSize: 18, color: Colors.white),
//     ),
//   );
// }


//   Widget _buildSignUpText() {
//     return TextButton(
//       onPressed: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => SimpleRegisterScreen()),
//       ),
//       child: RichText(
//         text: const TextSpan(
//           text: "I'm a new user, ",
//           style: TextStyle(color: Colors.black),
//           children: [
//             TextSpan(
//               text: 'Sign Up',
//               style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold), // Same sign-up text color
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
