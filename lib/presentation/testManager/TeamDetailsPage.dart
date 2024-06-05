import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamDetailsPage extends StatefulWidget {
  final String teamId;

  TeamDetailsPage({Key? key, required this.teamId}) : super(key: key);

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  Team? team;
  final TeamManager _teamManager = TeamManager();

  @override
  void initState() {
    super.initState();
    fetchTeamDetails();
  }

  void fetchTeamDetails() async {
    try {
      print('teamId to get: ${widget.teamId}');
      Team fetchedTeam = await _teamManager.getTeamById(widget.teamId);

      setState(() {
        team = fetchedTeam;
      });
    } catch (e) {
      print('Error fetching team details: $e');
      // Handle error appropriately
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
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
