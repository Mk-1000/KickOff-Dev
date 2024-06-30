part of 'create_team_bloc.dart';

@immutable
abstract class CreateTeamEvent {}

class Incrment extends  CreateTeamEvent{
  final String titre ;
  Incrment({required this.titre}); 
}
class Decrement extends  CreateTeamEvent{
  final String titre ;
  Decrement({required this.titre}); 
}