import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamSlotsPageInvitation extends StatefulWidget {
  final String teamId;

  TeamSlotsPageInvitation({required this.teamId});

  @override
  _TeamSlotsPageInvitationState createState() =>
      _TeamSlotsPageInvitationState();
}

class _TeamSlotsPageInvitationState extends State<TeamSlotsPageInvitation> {
  final InvitationManager _invitationManager = InvitationManager();
  final TeamManager _teamManager = TeamManager();
  Team? team;

  @override
  void initState() {
    super.initState();
    _loadTeam();
  }

  Future<void> _loadTeam() async {
    try {
      Team loadedTeam = await _teamManager.getTeamById(widget.teamId);
      setState(() {
        team = loadedTeam;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load team: $e')),
      );
    }
  }

  Future<void> _respondToInvitation(String invitationId, bool accept) async {
    try {
      await _invitationManager.respondToInvitation(invitationId, accept);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? 'Invitation accepted' : 'Invitation declined'),
        ),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to respond to invitation: $e')),
      );
    }
  }

  Future<void> _cancelInvitation(String invitationId) async {
    try {
      await _invitationManager.respondToInvitation(invitationId, false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invitation cancelled')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel invitation: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitations for ${team?.teamName ?? 'Team'}'),
      ),
      body: team == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Received Invitations:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Invitation>>(
                    future: _invitationManager
                        .fetchReceivedInvitationsForTeam(team!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No received invitations.'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Invitation invitation = snapshot.data![index];
                            return ListTile(
                              title: Text(
                                  'Invitation ID: ${invitation.invitationId}'),
                              subtitle: Text('Sender: ${invitation.playerId}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () => _respondToInvitation(
                                        invitation.invitationId, true),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => _respondToInvitation(
                                        invitation.invitationId, false),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sent Invitations:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Invitation>>(
                    future:
                        _invitationManager.fetchSentInvitationsForTeam(team!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No sent invitations.'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Invitation invitation = snapshot.data![index];
                            return ListTile(
                              title: Text(
                                  'Invitation ID: ${invitation.invitationId}'),
                              subtitle: Text('Receiver: ${invitation.teamId}'),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () =>
                                    _cancelInvitation(invitation.invitationId),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
