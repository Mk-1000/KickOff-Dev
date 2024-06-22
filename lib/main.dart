import 'package:flutter/material.dart';
import 'package:takwira/business/services/player_service.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/infrastructure/repositories/TeamRepository.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
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

  // await TeamManager().updateSlotStatusToPublic(
  //     "e0f2004d-1d39-4feb-bb0a-03dbbf74036f",
  //     "1e7085fe-a55b-4a29-94da-55ddfecbdf0b");

  // await InvitationManager().sendInvitationToTeam(
  //     teamId: "e0f2004d-1d39-4feb-bb0a-03dbbf74036f",
  //     playerId: "8kKrVpmGqiXeHjGI9XDGMDjNc7L2",
  //     slotId: "1e7085fe-a55b-4a29-94da-55ddfecbdf0b");

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
