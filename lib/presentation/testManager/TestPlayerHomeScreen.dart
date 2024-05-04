import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takwira/domain/entities/Player.dart';
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

  @override
  void initState() {
    super.initState();
    // Listen to changes in the Firebase Auth user state
    _firebaseAuth.userChanges().listen((User? user) async {
      if (user != null) {
        // Fetch the player details using the PlayerManager when user logs in
        try {
          Player player = await _playerManager.getPlayerDetails(user.uid);
          setState(() {
            _currentPlayer = player;
          });

          // Load teams for the current player using the TeamManager
          await _teamManager.loadTeamsForUser(_currentPlayer!.userId);
        } catch (e) {
          setState(() {
            _currentPlayer =
                null; // Reset player if there's an error fetching details
          });
          print('Error fetching player details: $e');
        }
      } else {
        setState(() {
          _currentPlayer = null; // Reset player if user logs out
        });
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _teamManager.teams.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_teamManager.teams[index].teamName),
                        // Add onTap functionality to view team details
                      );
                    },
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
