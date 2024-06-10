import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
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
  final _phoneNumbersController = TextEditingController();
  final _jerseySizeController = TextEditingController();
  Position? _preferredPosition; // Selected preferred position
  final PlayerManager _playerManager = PlayerManager();

  // List of predefined positions
  final List<Position> _positions = [
    Position.Goalkeeper,
    Position.Defender,
    Position.Midfielder,
    Position.Forward,
  ];

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
                _emailController,
                'Email',
                'Please enter a valid email',
                validator: (value) =>
                    value!.contains('@') ? null : 'Invalid email',
              ),
              _buildTextField(
                _passwordController,
                'Password',
                'Please enter a password',
                obscureText: true,
              ),
              _buildTextField(
                _nicknameController,
                'Nickname',
                'Please enter a nickname',
              ),
              _buildTextField(
                _birthdateController,
                'Birthdate (yyyy-MM-dd)',
                'Please enter birthdate',
                validator: (value) {
                  try {
                    DateFormat('yyyy-MM-dd').parseStrict(value!);
                    return null;
                  } catch (e) {
                    return 'Invalid date format';
                  }
                },
              ),
              _buildPositionDropdown(),
              _buildTextField(
                _phoneNumbersController,
                'Phone Numbers (comma-separated)',
                'Please enter phone numbers',
              ),
              _buildTextField(
                _jerseySizeController,
                'Jersey Size',
                'Please enter a jersey size',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _trySubmitForm,
                  child: Text('Sign Up'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TestSignInPlayer(),
                    ),
                  );
                },
                child: Text('Sign In Page'),
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

  Widget _buildPositionDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Position>(
        decoration: InputDecoration(
          labelText: 'Preferred Position',
          border: OutlineInputBorder(),
        ),
        value: _preferredPosition,
        onChanged: (value) {
          setState(() {
            _preferredPosition = value; // Update the selected position
          });
        },
        items: _positions.map((position) {
          return DropdownMenuItem<Position>(
            value: position,
            child: Text(position.toString().split('.').last),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select a preferred position';
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
        preferredPosition: _preferredPosition ?? Position.Goalkeeper,
        phoneNumbers: phoneNumbers,
        jerseySize: _jerseySizeController.text,
      );

      _playerManager
          .signUpPlayer(_emailController.text, _passwordController.text, player)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Player Registered Successfully! Go Sign IN')));
        Navigator.pop(context); // Navigate back to the previous screen
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to register player: $error')));
      });
    }
  }
}
