import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

import '../../domain/entities/Invitation.dart';

class TeamListPage extends StatefulWidget {
  final String homeTeamId;

  const TeamListPage({super.key, required this.homeTeamId});

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
        title: const Text('Team List'),
      ),
      body: StreamBuilder<List<Team>>(
        stream: teamsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No teams available'));
          } else {
            List<Team> teams = snapshot.data!;

            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                Team team = teams[index];
                return ListTile(
                  title: Text(team.teamName),
                  subtitle: Text('Number of Players: ${team.players.length}'),
                  trailing: FutureBuilder<bool>(
                    future: _invitationManager.isInvitationAlreadySent(
                      playerId: widget.homeTeamId,
                      slotId: team.teamId,
                      invitationType: InvitationType.TeamToTeam,
                    ),
                    builder: (context, invitationSnapshot) {
                      if (invitationSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const ElevatedButton(
                          onPressed: null,
                          child: Text('Checking...'),
                        );
                      } else if (invitationSnapshot.hasError) {
                        print(
                            'Error in FutureBuilder: ${invitationSnapshot.error}');
                        return const ElevatedButton(
                          onPressed: null,
                          child: Text('Error'),
                        );
                      } else if (!invitationSnapshot.hasData) {
                        print('No data available in FutureBuilder');
                        return const ElevatedButton(
                          onPressed: null,
                          child: Text('No Data'),
                        );
                      } else {
                        bool isInvitationSent = invitationSnapshot.data!;
                        return ElevatedButton(
                          onPressed: () => _toggleInvitation(
                            context,
                            widget.homeTeamId,
                            team.teamId,
                            isInvitationSent,
                          ),
                          child: Text(
                            isInvitationSent
                                ? 'Cancel Invitation'
                                : 'Send Invitation',
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _toggleInvitation(BuildContext context, String homeTeamId,
      String awayTeamId, bool isInvitationSent) async {
    if (isInvitationSent) {
      // Get the invitation ID
      String invitationId = await _invitationManager.searchInvitationId(
          playerId: homeTeamId,
          slotId: awayTeamId,
          invitationType: InvitationType.TeamToTeam);

      await _invitationManager.respondToInvitation(invitationId, false);
    } else {
      await _invitationManager.sendInvitationFromTeamToTeam(
          teamSenderId: homeTeamId, teamReceiverId: awayTeamId);
    }
  }
}
