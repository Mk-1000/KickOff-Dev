import 'package:flutter/material.dart';
import 'package:takwira/presentation/managers/UserManager.dart';

class TestSignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<TestSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserManager _userManager =
      UserManager(); // Assuming UserManager is properly initialized
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: _errorMessage,
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              autocorrect: false,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Sign In"),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 8),
              Text(_errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14))
            ],
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _userManager.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.of(context)
          .pop(); // Navigate back or to the main page after successful sign in
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
}
