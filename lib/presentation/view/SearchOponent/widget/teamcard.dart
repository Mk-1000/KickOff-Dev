import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/view/Profile/Profile.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String location;
  final String imageUrl;
  final int currentPlayers;
  final int maxPlayers;
  final VoidCallback onSendPressed;

  const TeamCard({
    Key? key,
    required this.teamName,
    required this.location,
    required this.imageUrl,
    required this.currentPlayers,
    required this.maxPlayers,
    required this.onSendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Team myTeam = Team(
      teamId: 'team123',
      teamName: 'My Awesome Team',
      captainId: 'player456',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      maxGoalkeepers: 1,
      maxDefenders: 4,
      maxMidfielders: 4,
      maxForwards: 2,
      players: ['player1', 'player2', 'player3'],
      slots: [],
      receivedSlotInvitations: {'player789': ['slot1', 'slot2']},
      sentSlotInvitations: {'player101': ['slot3']},
      gameHistoryIds: ['game1', 'game2'],
      receivedGameInvitationIds: ['game4'],
      sentGameInvitationIds: ['game5'],
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.grey, width: 1), // Grey border
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Team Avatar and Name
            GestureDetector(
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
              );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    teamName,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12), // Space between avatar and details

            // Team Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        location,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.personRunning, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "$currentPlayers/$maxPlayers players",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Send Button
            ElevatedButton(
              onPressed: onSendPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Envoyer",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
