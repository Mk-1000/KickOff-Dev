import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamsScreen extends StatefulWidget {
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final TeamManager _teamManager = TeamManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Teams'),
      ),
      body: StreamBuilder<List<Team>>(
        stream: _teamManager.streamAllTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Team team = snapshot.data![index];
                return ListTile(
                  title: Text(team.teamName),
                  subtitle: Text('Captain: ${team.captainId}'),
                  onTap: () {
                    // Handle tap if needed, for example, navigate to team details
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No teams available'));
          }
        },
      ),
    );
  }
}
