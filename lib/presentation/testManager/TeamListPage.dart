import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamListPage extends StatefulWidget {
  final String homeTeamId;

  TeamListPage({required this.homeTeamId});

  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  final TeamManager _teamManager = TeamManager();
  final InvitationManager _invitationManager = InvitationManager();

  Stream<List<Team>>? teamsStream;

  @override
  void initState() {
    super.initState();
    teamsStream = _teamManager
        .getAvailableTeamForGameStream(); // Initialize stream of teams
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team List'),
      ),
      body: StreamBuilder<List<Team>>(
        stream: teamsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No teams available'));
          } else {
            List<Team> teams = snapshot.data!;
            List<Team> availableTeams =
                teams.where((team) => team.isAvailable()).toList();

            if (availableTeams.isEmpty) {
              return Center(child: Text('No available teams'));
            }

            return ListView.builder(
              itemCount: availableTeams.length,
              itemBuilder: (context, index) {
                Team team = availableTeams[index];
                return ListTile(
                  title: Text(team.teamName),
                  subtitle: Text('Number of Players: ${team.players.length}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      sendInvitation(
                          team.teamId); // Send invitation for this team
                    },
                    child: Text('Send Invitation'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> sendInvitation(String teamId) async {
    try {
      await _invitationManager.sendInvitationFromTeamToTeam(
        teamSenderId: widget.homeTeamId,
        teamReceiverId: teamId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invitation sent successfully')),
      );
    } catch (e) {
      print('Failed to send invitation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send invitation')),
      );
    }
  }
}
