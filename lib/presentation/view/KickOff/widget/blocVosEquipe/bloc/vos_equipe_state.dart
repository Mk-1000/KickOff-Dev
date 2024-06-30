part of 'vos_equipe_bloc.dart';

@immutable
abstract class VosEquipeState {}

 class VosEquipeInitial extends VosEquipeState {}

 class dataLoaded extends VosEquipeState {
  final List<Team> teams ;
  dataLoaded({required this.teams}); 
 }

