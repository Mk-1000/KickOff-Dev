import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/testManager/ChatPage.dart';
import 'package:takwira/presentation/testManager/ImageUploadScreen.dart';
import 'package:takwira/presentation/testManager/PlayerInvitationPage.dart';
import 'package:takwira/presentation/testManager/PublicAvailableSlotsScreen.dart';
import 'package:takwira/presentation/testManager/TeamDetailsPage.dart';
import 'package:takwira/presentation/testManager/TeamSlotsPageInvitaion.dart';
import 'package:takwira/presentation/testManager/TestCreateTeamPage.dart';

class PlayerHomePage extends StatefulWidget {
  final String playerId;

  PlayerHomePage({Key? key, required this.playerId}) : super(key: key);

  @override
  _PlayerHomePageState createState() => _PlayerHomePageState();
}

class _PlayerHomePageState extends State<PlayerHomePage> {
  final PlayerManager _playerManager = PlayerManager();
  final TeamManager _teamManager = TeamManager();
  Player? player;
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    try {
      player = await _playerManager.getPlayerDetails(widget.playerId);
      if (player != null) {
        teams = await _teamManager.getTeamsForPlayer(player!);
      }
      setState(() {});
    } catch (e) {
      print('Error initializing player home page: $e');
      // Optionally, display a snackbar or other error message to the user.
    }
  }

  Future<void> _deleteTeam(String teamId) async {
    if (player == null) {
      print('Error: Player data is null.');
      return;
    }
    try {
      await _teamManager.deleteTeamForPlayer(
          teamId, Player.currentPlayer!.playerId);
      // Update teams list and UI only if delete operation was successful
      teams.removeWhere((team) => team.teamId == teamId);
      setState(() {});
    } catch (e) {
      print('Error deleting player team: $e');
      // Optionally, inform the user of the failure to delete the team.
    }
  }

  void _addNewTeam(Team newTeam) {
    if (player != null) {
      teams.add(newTeam);
      player!.teamIds
          .add(newTeam.teamId); // Assuming each team has a unique teamId
      setState(() {});
    }
  }

  // Function to navigate to the upload page
  void _navigateToUploadPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadManagerScreen(),
      ),
    );
  }

  void _navigateToChatPage(String chatId) {
    print(
        'ChatId is $chatId'); // Print statement moved outside the MaterialPageRoute builder
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(chatId: chatId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to players screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PlayerInvitationPage(playerId: widget.playerId)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              // Navigate to players screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PublicAvailableSlotsScreen()),
              );
            },
          ),
        ],
      ),
      body: player == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Welcome, ${player!.nickname}',
                      style: TextStyle(fontSize: 20)),
                ),
                // ElevatedButton(
                //   onPressed: _navigateToUploadPage,
                //   child: Text("Upload Images"),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(teams[index].teamName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _deleteTeam(teams[index].teamId),
                              ),
                              IconButton(
                                icon: Icon(Icons.notification_add_sharp),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TeamSlotsPageInvitation(
                                            teamId: teams[index].teamId),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.message, color: Colors.blue),
                                onPressed: () => _navigateToChatPage(
                                    teams[index].chatId.toString()),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TeamDetailsPage(
                                        teamId: teams[index].teamId),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TestCreateTeamPage(onTeamCreated: _addNewTeam)),
                    ),
                    child: Text("Create a new Team"),
                  ),
                ),
              ],
            ),
    );
  }
}
