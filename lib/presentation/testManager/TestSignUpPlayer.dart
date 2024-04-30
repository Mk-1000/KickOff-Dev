import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/testManager/TestSignInPlayer.dart';

class TestSignUpPlayer extends StatefulWidget {
  @override
  _SignUpPlayerPageState createState() => _SignUpPlayerPageState();
}

class _SignUpPlayerPageState extends State<TestSignUpPlayer> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _preferredPositionController = TextEditingController();
  final _phoneNumbersController = TextEditingController();
  final _jerseySizeController = TextEditingController();
  final PlayerManager _playerManager =
      PlayerManager(); // Ensure this is initialized properly.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Player"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextField(
                  _emailController, 'Email', 'Please enter a valid email',
                  validator: (value) =>
                      value!.contains('@') ? null : 'Invalid email'),
              _buildTextField(
                  _passwordController, 'Password', 'Please enter a password',
                  obscureText: true),
              _buildTextField(
                  _nicknameController, 'Nickname', 'Please enter a nickname'),
              _buildTextField(_birthdateController, 'Birthdate (yyyy-MM-dd)',
                  'Please enter birthdate', validator: (value) {
                try {
                  DateFormat('yyyy-MM-dd').parseStrict(value!);
                  return null;
                } catch (e) {
                  return 'Invalid date format';
                }
              }),
              _buildTextField(_preferredPositionController,
                  'Preferred Position', 'Please enter a preferred position'),
              _buildTextField(
                  _phoneNumbersController,
                  'Phone Numbers (comma-separated)',
                  'Please enter phone numbers'),
              _buildTextField(_jerseySizeController, 'Jersey Size',
                  'Please enter a jersey size'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _trySubmitForm,
                  child: Text('Sign Up'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TestSignInPlayer()));
                },
                child: Text('SignInPage'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String errorText, {
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return errorText;
              }
              return null;
            },
      ),
    );
  }

  void _trySubmitForm() {
    if (_formKey.currentState!.validate()) {
      DateTime birthdate;
      try {
        birthdate =
            DateFormat('yyyy-MM-dd').parseStrict(_birthdateController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid birthdate format')));
        return;
      }

      List<String> phoneNumbers =
          _phoneNumbersController.text.split(',').map((e) => e.trim()).toList();

      var player = Player(
        email: _emailController.text,
        nickname: _nicknameController.text,
        birthdate: birthdate,
        preferredPosition: _preferredPositionController.text,
        phoneNumbers: phoneNumbers,
        jerseySize: _jerseySizeController.text,
      );

      _playerManager
          .signUpPlayer(_emailController.text, _passwordController.text, player)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Player Registered Successfully! Go Sign IN')));
        Navigator.pop(
            context); // Optionally navigate away upon successful registration
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to register player: $error')));
      });
    }
  }
}
