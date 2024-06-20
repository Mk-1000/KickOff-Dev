import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/testManager/ChatManagerTestPage.dart';
import 'package:takwira/presentation/testManager/ShowAllTeams.dart';
import 'package:takwira/presentation/testManager/TestSignInPlayer.dart';
import 'package:takwira/presentation/view/Onbording/Onbording.dart';
import 'package:takwira/presentation/view/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes().lightTheme,
      home: TestSignInPlayer(),
    );
  }
}
