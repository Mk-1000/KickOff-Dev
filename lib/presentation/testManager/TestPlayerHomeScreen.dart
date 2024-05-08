import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/Managers/PlayerManager.dart';
import 'package:takwira/presentation/Managers/TeamManager.dart';
import 'package:takwira/presentation/testManager/CreateTeam.dart';
import 'package:takwira/presentation/testManager/TeamDetailsPage.dart';

class TestHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TestHomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PlayerManager _playerManager = PlayerManager();
  final TeamManager _teamManager = TeamManager();

  Player? _currentPlayer;
  List<Team> _teams = []; // Correctly initialized as an empty list

  @override
  void initState() {
    super.initState();
    _firebaseAuth.userChanges().listen((User? user) async {
      if (user != null) {
        try {
          Player player = await _playerManager.getPlayerDetails(user.uid);
          List<Team> teams =
              await _teamManager.getAllTeamsForPlayer(player.teamIds);
          setState(() {
            _currentPlayer = player;
            _teams = teams; // Assuming _teams is a List<Team> in your state
          });
        } catch (e) {
          print('Error fetching player details or teams: $e');
          if (mounted) {
            setState(() {
              _currentPlayer = null;
              _teams = []; // Ensure the list is cleared on error
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _currentPlayer = null;
            _teams =
                []; // Ensure the list is cleared if the user is not signed in
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: _currentPlayer != null && _teams.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_currentPlayer!.nickname}'),
                  SizedBox(height: 20),
                  Text('Your Teams:'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _teams.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_teams[index].teamName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () {
                                  // Implement navigation to team details
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TeamDetailsPage(
                                        teamId: _teams[index].teamId),
                                  ));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  // Implement deletion logic
                                  try {
                                    await _teamManager
                                        .deleteTeam(_teams[index].teamId);
                                    setState(() {
                                      _teams.removeAt(index);
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Failed to delete team: $e'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            // Optionally keep this tap handler if you want to do something else on tap
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateTeamPage()));
                    },
                    child: Text('Create New Team'),
                  ),
                ],
              )
            : Text('Not signed in or no teams to display'),
      ),
    );
  }
}
