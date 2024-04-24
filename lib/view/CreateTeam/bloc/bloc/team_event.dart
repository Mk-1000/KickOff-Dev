abstract class TeamEvent {}

class IncrementTeamCount extends TeamEvent {}

class DecrementTeamCount extends TeamEvent {}

class IncrementPlayerCount extends TeamEvent {
  final String position;

  IncrementPlayerCount(this.position);
}

class DecrementPlayerCount extends TeamEvent {
  final String position;

  DecrementPlayerCount(this.position);
}
