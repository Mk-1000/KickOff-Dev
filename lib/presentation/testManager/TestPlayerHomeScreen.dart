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
  Stream<List<Team>>? _teamStream;

  @override
  void initState() {
    super.initState();
    _firebaseAuth.userChanges().listen((User? user) async {
      if (user != null) {
        try {
          Player player = await _playerManager.getPlayerDetails(user.uid);
          _teamStream = _teamManager
              .streamAllTeams(); // Adjust this line to fit your actual method
          setState(() {
            _currentPlayer = player;
          });
        } catch (e) {
          print('Error fetching player details: $e');
          if (mounted) {
            setState(() {
              _currentPlayer = null;
              _teamStream = null;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _currentPlayer = null;
            _teamStream = null;
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
        child: _currentPlayer != null && _teamStream != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${_currentPlayer!.nickname}'),
                  SizedBox(height: 20),
                  Text('Your Teams:'),
                  Expanded(
                    child: StreamBuilder<List<Team>>(
                      stream: _teamStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        var teams = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: teams.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(teams[index].teamName),
                              onTap: () {
                                // Implement navigation to team details
                              },
                            );
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
