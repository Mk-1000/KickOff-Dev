import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';
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

  // Team team = await TeamRepository()
  //     .getTeamById("487a276b-3406-47e2-a39b-5c18dda37214");

  // // Convert JSON to Team object
  // //final team = Team.fromJson(teamJson);
  // print(team.teamId);
  // print(team.teamName);
  // print(team.captainId);
  // print(team.players);

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
