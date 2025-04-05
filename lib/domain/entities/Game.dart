import '../../utils/DateTimeUtils.dart';
import '../../utils/IDUtils.dart';
import '../../utils/Parse.dart';

enum GameStatus { Scheduled, InProgress, Completed, Canceled, Pending }

class Game {
  String gameId;
  String homeTeam;
  String awayTeam;
  int? _gameDate; // Private field for internal storage
  String? stadiumId;
  String? chatId;
  GameStatus? gameStatus;
  final int createdAt;
  int updatedAt;

  Game({
    required this.homeTeam,
    required this.awayTeam,
    DateTime? gameDate,
    this.stadiumId,
    this.chatId,
    GameStatus? gameStatus,
    int? createdAt,
    int? updatedAt,
  })  : _gameDate =
            gameDate != null ? DateTimeUtils.toTimestamp(gameDate) : null,
        gameId = IDUtils.generateUniqueId(),
        gameStatus =
            gameStatus ?? GameStatus.Pending, // Default value for gameStatus
        createdAt = createdAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch,
        updatedAt = updatedAt ??
            DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;

  // Getter for gameDate, converting int to DateTime for external use
  DateTime? get gameDate => _gameDate != null
      ? DateTime.fromMillisecondsSinceEpoch(_gameDate!)
      : null;

  // Setter for gameDate, converting DateTime to int internally
  set gameDate(DateTime? date) {
    _gameDate = date?.millisecondsSinceEpoch;
  }

  void newUpdate() {
    updatedAt = DateTimeUtils.getCurrentDateTime().millisecondsSinceEpoch;
  }

  void updateGameStatus(GameStatus newStatus) {
    gameStatus = newStatus;
  }

  void updateStadiumId(String newStadiumId) {
    stadiumId = newStadiumId;
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'gameDate': _gameDate,
      'stadiumId': stadiumId,
      'chatId': chatId,
      'gameStatus': gameStatus.toString().split('.').last,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    String gameId = json['gameId'] as String? ?? IDUtils.generateUniqueId();

    return Game(
      homeTeam: json['homeTeam'],
      awayTeam: json['awayTeam'],
      gameDate: json['gameDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['gameDate'])
          : null,
      stadiumId: json['stadiumId'],
      chatId: json['chatId'] as String?,
      gameStatus: ParserUtils.parseGameStatus(json['gameStatus']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    )..gameId = gameId;
  }
}
