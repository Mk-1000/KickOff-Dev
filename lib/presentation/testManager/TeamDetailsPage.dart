import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/Managers/TeamManager.dart';

class TeamDetailsPage extends StatelessWidget {
  final String teamId;
  final TeamManager teamManager = TeamManager();

  TeamDetailsPage({required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
      ),
      body: FutureBuilder<Team>(
        future: teamManager.getTeamById(teamId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error.toString()}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Retry'),
                    onPressed: () {
                      // Triggering a state update to retry fetching
                      (context as Element).reassemble();
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            Team team = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Team ID: ${team.teamId}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Captain ID: ${team.captainId}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Chat: ${team.chat}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Players:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...team.players.keys
                      .map((id) => Text(
                          '$id: ${team.players[id]! ? "Active" : "Inactive"}'))
                      .toList(),
                ],
              ),
            );
          } else {
            return Center(child: Text('No team data available'));
          }
        },
      ),
    );
  }
}
