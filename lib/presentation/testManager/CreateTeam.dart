import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/Managers/TeamManager.dart';

class CreateTeamPage extends StatefulWidget {
  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final TeamManager _teamManager = TeamManager();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _teamNameController,
              decoration: InputDecoration(labelText: 'Team Name'),
            ),
            TextField(
              controller: _chatController,
              decoration: InputDecoration(labelText: 'Chat'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Create new team using input values
                Team newTeam = Team(
                  teamName: _teamNameController.text,
                  captainId: Player.currentPlayer!.playerId,
                  players: {}, // Initialize players with an empty map
                  chat: _chatController.text,
                );

                // Add new team using TeamManager
                await _teamManager.addTeamForPlayer(
                    newTeam, Player.currentPlayer!);

                // Navigate back to previous screen
                Navigator.pop(context);
              },
              child: Text('Create Team'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _chatController.dispose();
    super.dispose();
  }
}
