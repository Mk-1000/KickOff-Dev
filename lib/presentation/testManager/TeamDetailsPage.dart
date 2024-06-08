import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/domain/entities/Player.dart';

class TeamDetailsPage extends StatefulWidget {
  final String teamId;

  TeamDetailsPage({Key? key, required this.teamId}) : super(key: key);

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  Team? team;
  final TeamManager _teamManager = TeamManager();
  final PlayerManager _playerManager = PlayerManager();
  List<Player> availablePlayers = [];

  @override
  void initState() {
    super.initState();
    fetchTeamDetails();
    fetchAvailablePlayers();
  }

  void fetchTeamDetails() async {
    try {
      Team fetchedTeam = await _teamManager.getTeamById(widget.teamId);
      setState(() {
        team = fetchedTeam;
      });
    } catch (e) {
      print('Error fetching team details: $e');
      // Handle error appropriately
    }
  }

  void fetchAvailablePlayers() async {
    try {
      List<Player> players = await _playerManager.getPlayers();
      setState(() {
        availablePlayers = players;
      });
    } catch (e) {
      print('Error fetching available players: $e');
      // Handle error appropriately
    }
  }

  void _invitePlayer(Player player, String position, int placeNumber) async {
    if (team != null) {
      try {
        await _teamManager.sendInvitation(
            team!.teamId, player.playerId, position, placeNumber);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invitation sent to ${player.nickname}')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send invitation: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
      ),
      body: team != null
          ? Center(
              child: Column(
                children: [
                  Text('Team Name: ${team!.teamName}'),
                  // Add more team details here
                  Expanded(
                    child: ListView.builder(
                      itemCount: availablePlayers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(availablePlayers[index].nickname),
                            trailing: IconButton(
                              icon: Icon(Icons.person_add),
                              onPressed: () => _invitePlayer(
                                  availablePlayers[index],
                                  'defender',
                                  index + 1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
