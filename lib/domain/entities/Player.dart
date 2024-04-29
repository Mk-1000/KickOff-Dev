import 'package:takwira/domain/entities/User.dart';

class Player extends User {
  final String _nickname;
  final DateTime _birthdate;
  final String _preferredPosition;
  final List<String> _phoneNumbers;
  final String _jerseySize;

  Player({
    String? userId, // Ensure userId can be passed to Player
    required String email,
    required String nickname,
    required DateTime birthdate,
    required String preferredPosition,
    required List<String> phoneNumbers,
    required String jerseySize,
  })  : _nickname = nickname,
        _birthdate = birthdate,
        _preferredPosition = preferredPosition,
        _phoneNumbers = phoneNumbers,
        _jerseySize = jerseySize,
        super(
            userId: userId,
            email: email,
            role: UserRole.player); // Pass userId to super

  String get nickname => _nickname;
  DateTime get birthdate => _birthdate;
  String get preferredPosition => _preferredPosition;
  List<String> get phoneNumbers => _phoneNumbers;
  String get jerseySize => _jerseySize;

  String get playerId =>
      userId; // Player ID is now the User ID directly from User base class

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'nickname': _nickname,
      'birthdate': _birthdate.millisecondsSinceEpoch,
      'preferredPosition': _preferredPosition,
      'phoneNumbers': _phoneNumbers,
      'jerseySize': _jerseySize,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      userId: json['userId'], // Ensure userId is obtained from JSON
      email: json['email'],
      nickname: json['nickname'],
      birthdate: DateTime.fromMillisecondsSinceEpoch(json['birthdate']),
      preferredPosition: json['preferredPosition'],
      phoneNumbers: List<String>.from(json['phoneNumbers']),
      jerseySize: json['jerseySize'],
    );
  }
}
