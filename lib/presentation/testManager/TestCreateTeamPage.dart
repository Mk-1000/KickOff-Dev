import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TestCreateTeamPage extends StatefulWidget {
  final Function(Team) onTeamCreated;

  TestCreateTeamPage({Key? key, required this.onTeamCreated}) : super(key: key);

  @override
  _TestCreateTeamPageState createState() => _TestCreateTeamPageState();
}

class _TestCreateTeamPageState extends State<TestCreateTeamPage> {
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
                if (Player.currentPlayer != null) {
                  // Create new team using input values
                  Team newTeam = Team(
                    teamName: _teamNameController.text,
                    captainId: Player.currentPlayer!
                        .playerId, // Ensure the currentPlayer is not null
                    players: {}, // Initialize players with an empty map
                    chat: _chatController.text,
                  );

                  // Add new team using TeamManager and check for any possible failure
                  try {
                    await _teamManager.addTeamForPlayer(
                        newTeam, Player.currentPlayer!);
                    // If successful, call the onTeamCreated callback
                    widget.onTeamCreated(newTeam);
                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  } catch (e) {
                    // Handle any errors, e.g., show an error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Failed to create team: ${e.toString()}')));
                  }
                } else {
                  // Handle null currentPlayer appropriately
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No current player available.')));
                }
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
