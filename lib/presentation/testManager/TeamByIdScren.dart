import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamSearchByIdScreen extends StatefulWidget {
  @override
  _TeamSearchScreenState createState() => _TeamSearchScreenState();
}

class _TeamSearchScreenState extends State<TeamSearchByIdScreen> {
  final TextEditingController _controller = TextEditingController();
  Team? _team;
  String _errorMessage = '';

  Future<void> _fetchTeam() async {
    try {
      String teamId = _controller.text.trim();
      if (teamId.isEmpty) {
        setState(() {
          _errorMessage = "Please enter a team ID";
        });
        return;
      }
      TeamManager teamManager =
          TeamManager(); // Assuming TeamManager is available
      Team team = await teamManager.getTeamById(teamId);
      setState(() {
        _team = team;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _team = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Team by ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter team ID',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchTeam,
              child: Text('Get Team'),
            ),
            SizedBox(height: 20),
            if (_team != null) ...[
              Text('Team Name: ${_team!.teamName}',
                  style: TextStyle(fontSize: 18)),
              Text('Captain ID: ${_team!.captainId}',
                  style: TextStyle(fontSize: 18)),
              // Add more details as needed
            ],
            if (_errorMessage.isNotEmpty)
              Text('Error: $_errorMessage',
                  style: TextStyle(color: Colors.red, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
