part of 'create_team_bloc.dart';

@immutable
abstract class CreateTeamState {}

class CreateTeamInitial extends CreateTeamState {
  final int defender;
  final int attacker;
  final int midle;
  CreateTeamInitial(
      {required this.defender, required this.attacker, required this.midle});
}
