import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/Managers/PlayerManager.dart';
import 'package:takwira/presentation/Managers/TeamManager.dart';
import 'package:takwira/presentation/testManager/CreateTeam.dart';

class TestHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TestHomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PlayerManager _playerManager = PlayerManager();
  final TeamManager _teamManager = TeamManager();

  Player? _currentPlayer;
  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    _firebaseAuth.userChanges().listen((User? user) async {
      if (user != null) {
        try {
          Player player = await _playerManager.getPlayerDetails(user.uid);
          List<Team> teams = await _teamManager.getTeamsForPlayer(player);
          if (mounted) {
            setState(() {
              _currentPlayer = player;
              _teams = teams; // Ensure this is updated with fetched teams
            });
          }
        } catch (e) {
          print('Error fetching player details: $e');
          if (mounted) {
            setState(() {
              _currentPlayer = null;
              _teams = [];
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _currentPlayer = null;
            _teams = [];
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
        child: _currentPlayer != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_currentPlayer!.nickname}'),
                  SizedBox(height: 20),
                  Text('Your Teams:'),
                  Expanded(
                    // Use Expanded widget for ListView inside Column
                    child: ListView.builder(
                      itemCount: _teams
                          .length, // Make sure it's _teams not _teamManager.teams
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_teams[index].teamName),
                          onTap: () {
                            // Optional: Implement navigation to team details
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
            : Text('Not signed in'),
      ),
    );
  }
}
