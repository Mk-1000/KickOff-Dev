import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';

class TeamDetailsPage extends StatelessWidget {
  final Team team;

  TeamDetailsPage({required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.teamName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team Name
              Text(
                team.teamName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              // Team ID
              Text('Team ID: ${team.teamId}'),

              SizedBox(height: 16),

              // Captain ID
              Text('Captain ID: ${team.captainId}'),

              SizedBox(height: 16),

              // Address ID (if available)
              if (team.addressId != null) Text('Address ID: ${team.addressId}'),

              SizedBox(height: 16),

              // Player Count
              Text('Players: ${team.players.length}'),

              SizedBox(height: 16),

              // Position Slots
              Text(
                'Position Slots:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: team.slots.map((slot) {
                  return Text(
                      '- ${slot.position}: ${slot.playerId ?? "Available"}');
                }).toList(),
              ),

              SizedBox(height: 16),

              // Max Positions
              Text(
                'Max Positions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Goalkeepers: ${team.maxGoalkeepers}'),
              Text('Defenders: ${team.maxDefenders}'),
              Text('Midfielders: ${team.maxMidfielders}'),
              Text('Forwards: ${team.maxForwards}'),

              SizedBox(height: 16),

              // Game Details
              if (team.currentGameId != null)
                Text('Current Game ID: ${team.currentGameId}'),

              SizedBox(height: 16),

              Text('Game History IDs:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    team.gameHistoryIds.map((id) => Text('- $id')).toList(),
              ),

              SizedBox(height: 16),

              // Slot Invitations (Received and Sent) - Example Display
              Text(
                'Slot Invitations:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Received: ${team.receivedSlotInvitations.length}'),
              Text('Sent: ${team.sentSlotInvitations.length}'),

              SizedBox(height: 16),

              // Game Invitations (Received and Sent) - Example Display
              Text(
                'Game Invitations:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Received: ${team.receivedGameInvitationIds.length}'),
              Text('Sent: ${team.sentGameInvitationIds.length}'),

              // Add more fields as needed...
            ],
          ),
        ),
      ),
    );
  }
}
