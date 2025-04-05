import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/utils/DateTimeUtils.dart';

import '../../domain/entities/Invitation.dart';

class PublicAvailableSlotsScreen extends StatelessWidget {
  final TeamManager teamManager = TeamManager();
  final InvitationManager invitationManager = InvitationManager();

  PublicAvailableSlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Available Slots'),
      ),
      body: StreamBuilder<List<PositionSlot>>(
        stream: teamManager.getPublicAvailableSlotsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No available slots found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                PositionSlot slot = snapshot.data![index];

                // Use FutureBuilder to asynchronously fetch team details
                return FutureBuilder<Team>(
                  future: teamManager.getTeamById(slot.teamId),
                  builder: (context, teamSnapshot) {
                    if (teamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return _buildSlotTile(slot,
                          null); // Placeholder until team details are fetched
                    } else if (teamSnapshot.hasError) {
                      return _buildSlotTile(slot, null); // Handle error case
                    } else if (!teamSnapshot.hasData) {
                      return _buildSlotTile(slot, null); // No team found case
                    } else {
                      Team team = teamSnapshot.data!;
                      return _buildTeamWithSlotTile(context, team, slot);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTeamWithSlotTile(
      BuildContext context, Team team, PositionSlot slot) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Details
            Text(
              "Team Name: ${team.teamName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            // Other team details you want to show

            // Slot Details
            const Divider(),
            ListTile(
              title: Text('${slot.position} - ${slot.status}'),
              subtitle: Text(
                  'Published on: ${DateTimeUtils.formatTimestamp(slot.slotTypeChangedAt)}'),
            ),
            const SizedBox(height: 8.0),
            FutureBuilder<bool>(
              future: invitationManager.isInvitationAlreadySent(
                  playerId: Player.currentPlayer!.playerId,
                  slotId: slot.slotId,
                  invitationType: InvitationType.PlayerToTeam,
                  teamId: slot.teamId),
              builder: (context, invitationSnapshot) {
                if (invitationSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const ElevatedButton(
                    onPressed: null,
                    child: Text('Checking...'),
                  );
                } else if (invitationSnapshot.hasError) {
                  return const ElevatedButton(
                    onPressed: null,
                    child: Text('Error'),
                  );
                } else {
                  bool isInvitationSent = invitationSnapshot.data ?? false;
                  return ElevatedButton(
                    onPressed: () => _toggleInvitation(
                        context, team, slot, isInvitationSent),
                    child: Text(isInvitationSent
                        ? 'Cancel Invitation'
                        : 'Send Invitation'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotTile(PositionSlot slot, Team? team) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            team != null
                ? Text(
                    "Team Name: ${team.teamName}",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  )
                : const Text('Slot not associated with a team'),
            const SizedBox(height: 8.0),
            ListTile(
              title: Text('${slot.position} - ${slot.status}'),
              subtitle: Text(
                  'Published on: ${DateTimeUtils.formatTimestamp(slot.slotTypeChangedAt)}'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleInvitation(BuildContext context, Team team,
      PositionSlot slot, bool isInvitationSent) async {
    if (isInvitationSent) {
      // Get the invitation ID
      String invitationId = await invitationManager.searchInvitationId(
          playerId: Player.currentPlayer!.playerId,
          slotId: slot.slotId,
          teamId: team.teamId,
          invitationType: InvitationType.PlayerToTeam);

      await invitationManager.respondToInvitation(invitationId, false);
    } else {
      await invitationManager.sendInvitationFromPlayerToTeam(
        teamId: slot.teamId,
        playerId: Player.currentPlayer!.playerId,
        slotId: slot.slotId,
      );
    }
  }
}
