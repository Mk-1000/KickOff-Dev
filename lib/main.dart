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
  //     "30325fa5-a630-4f94-ad61-a78729901407",
  //     "751c4c78-3406-4c69-b18a-1f6959fe3d2c");

  // await InvitationManager().sendInvitationToTeam(
  //     teamId: "30325fa5-a630-4f94-ad61-a78729901407",
  //     playerId: "whAbpvIFEJOCg1euutJCLcZtHmR2",
  //     slotId: "751c4c78-3406-4c69-b18a-1f6959fe3d2c");

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
