import 'package:flutter/material.dart';

class TabnineSignIn extends StatefulWidget {
  const TabnineSignIn({super.key});

  @override
  _TabnineSignInState createState() => _TabnineSignInState();
}

class _TabnineSignInState extends State<TabnineSignIn> {
  final TextEditingController _tokenController = TextEditingController();

  void _signIn() {
    String token = _tokenController.text;
    // Implement the sign-in logic with the provided token
    // For example, you might call an API to authenticate with Tabnine
    print("Signing in with token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabnine Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'Auth Token',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
