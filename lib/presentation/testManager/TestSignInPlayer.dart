import 'package:flutter/material.dart';
import 'package:takwira/presentation/Managers/PlayerManager.dart';
import 'package:takwira/presentation/testManager/TestPlayerHomeScreen.dart';
import 'package:takwira/presentation/testManager/TestSignUpPlayer.dart';

class TestSignInPlayer extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<TestSignInPlayer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PlayerManager _playerManager =
      PlayerManager(); // Assuming PlayerManager is properly set up

  void _signIn() async {
    try {
      var currentPlayerId = await _playerManager.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      // Use the returned currentPlayerId for navigation.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlayerHomePage(playerId: currentPlayerId),
      ));
    } catch (e) {
      _showErrorDialog('Failed to sign in: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Sign In Failed'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TestSignUpPlayer()));
              },
              child: Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:takwira/presentation/Managers/PlayerManager.dart';
// import 'package:takwira/presentation/testManager/TestPlayerHomeScreen.dart';

// class TestSignInPlayer extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<TestSignInPlayer> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     _checkAuthentication();
//   }

//   void _checkAuthentication() async {
//     // Listen to the auth state changes
//     _firebaseAuth.authStateChanges().listen((User? user) {
//       if (user != null) {
//         // If user is already signed in, navigate to the home screen
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => TestHomeScreen()));
//       }
//     });
//   }

//   void _signIn() async {
//     try {
//       // Attempt to sign in with email and password
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // Navigate to the home screen upon successful sign in
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => TestHomeScreen()));
//     } catch (e) {
//       // Show an error message if sign in fails
//       _showErrorDialog(e.toString());
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Sign In Failed'),
//         content: Text(message),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: Text('Okay'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Player Sign In'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _signIn,
//               child: Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
