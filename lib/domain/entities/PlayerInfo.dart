import 'package:takwira/domain/entities/Team.dart';

class PlayerInfo {
  String playerName;
  Position position;
  int number;

  PlayerInfo({
    required this.playerName,
    required this.position,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'position': position.toString().split('.').last,
      'number': number,
    };
  }

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      playerName: json['playerName'] as String,
      position: Position.values.firstWhere(
          (e) => e.toString().split('.').last == json['position'] as String),
      number: json['number'] as int,
    );
  }
}
