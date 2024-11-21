import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Stadium.dart';
import 'package:takwira/presentation/managers/GameManager.dart';
import 'package:takwira/presentation/managers/StadiumManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import '../../domain/entities/Game.dart';
import 'package:takwira/utils/DateTimeUtils.dart';
import '../../domain/entities/Team.dart';
import 'ChatPage.dart';
import 'StadiumListScreen.dart';

class GameDetailsPage extends StatefulWidget {
  final String gameId;

  GameDetailsPage({required this.gameId});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  final GameManager _gameManager = GameManager();
  final TeamManager _teamManager = TeamManager();
  late Future<Game?> _gameFuture;
  late Future<Team?> _homeTeamFuture;
  late Future<Team?> _awayTeamFuture;
  Future<Stadium?>? _stadiumFuture;

  Game? game;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _gameFuture = _loadGame();
  }

  Future<Game?> _loadGame() async {
    try {
      final loadedGame = await _gameManager.getGameDetails(widget.gameId);
      setState(() {
        game = loadedGame;
        if (game != null) {
          _selectedDate = game!.gameDate;
          _homeTeamFuture = _teamManager.getTeamById(game!.homeTeam);
          _awayTeamFuture = _teamManager.getTeamById(game!.awayTeam);
          if (game!.stadiumId != null) {
            _stadiumFuture = _getStadiumInfo(game!.stadiumId!);
          }
        }
      });
      return loadedGame;
    } catch (e) {
      debugPrint('Error loading game: $e');
      return null;
    }
  }

  Future<void> _quitGame() async {
    try {
      await _gameManager.deleteGame(widget.gameId);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error quitting game: $e');
    }
  }

  Future<Stadium> _getStadiumInfo(String stadiumId) async {
    return await StadiumManager().getStadiumDetails(stadiumId);
  }

  Future<void> _navigateToChatPage() async {
    final Game currGame = await _gameManager.getGameDetails(widget.gameId);

    if (currGame.chatId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(chatId: currGame.chatId!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Chat ID Missing'),
          content: Text('Chat ID is not available for this game.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? now),
      );
      if (pickedTime != null) {
        final pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          _selectedDate = pickedDateTime;
        });
        try {
          await _gameManager.updateGameDate(widget.gameId, pickedDateTime);
          setState(() {
            _gameFuture = _loadGame();
          });
        } catch (e) {
          debugPrint('Error updating game date: $e');
        }
      }
    }
  }

  Future<void> _navigateToStadiumListScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StadiumListScreen(gameId: widget.gameId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: _navigateToChatPage,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _quitGame,
          ),
        ],
      ),
      body: FutureBuilder<Game?>(
        future: _gameFuture,
        builder: (context, gameSnapshot) {
          if (gameSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (gameSnapshot.hasError) {
            return Center(child: Text('Error: ${gameSnapshot.error}'));
          } else if (gameSnapshot.data == null) {
            return Center(child: Text('Game not found'));
          } else {
            game = gameSnapshot.data; // Update game with gameSnapshot data
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<Team?>(
                    future: _homeTeamFuture,
                    builder: (context, homeTeamSnapshot) {
                      if (homeTeamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Text('Loading home team...');
                      } else if (homeTeamSnapshot.hasError) {
                        return Text('Error loading home team');
                      } else if (homeTeamSnapshot.data == null) {
                        return Text('Home team not found');
                      } else {
                        final homeTeam = homeTeamSnapshot.data!;
                        return Text(
                          'Home Team: ${homeTeam.teamName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  FutureBuilder<Team?>(
                    future: _awayTeamFuture,
                    builder: (context, awayTeamSnapshot) {
                      if (awayTeamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Text('Loading away team...');
                      } else if (awayTeamSnapshot.hasError) {
                        return Text('Error loading away team');
                      } else if (awayTeamSnapshot.data == null) {
                        return Text('Away team not found');
                      } else {
                        final awayTeam = awayTeamSnapshot.data!;
                        return Text(
                          'Away Team: ${awayTeam.teamName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Game Date: ${game!.gameDate != null ? DateTimeUtils.formatTimestamp(game!.gameDate!.millisecondsSinceEpoch) : 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  FutureBuilder<Stadium?>(
                    future: _stadiumFuture,
                    builder: (context, stadiumSnapshot) {
                      if (stadiumSnapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading stadium...');
                      } else if (stadiumSnapshot.hasError) {
                        return Text('Error loading stadium');
                      } else if (stadiumSnapshot.data == null) {
                        return Text('Stadium not selected');
                      } else {
                        final stadium = stadiumSnapshot.data!;
                        return Text(
                          'Stadium: ${stadium.name}',
                          style: TextStyle(fontSize: 16),
                        );
                      }
                    },
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDateTime(context),
                        child: Text('Select Schedule'),
                      ),
                      ElevatedButton(
                        onPressed: () => _navigateToStadiumListScreen(),
                        child: Text('Select Stadium'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
