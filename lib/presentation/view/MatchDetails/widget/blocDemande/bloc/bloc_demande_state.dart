part of 'bloc_demande_bloc.dart';

@immutable
abstract class BlocDemandeState {}

 class BlocDemandeInitial extends BlocDemandeState {}
 class dataLoaded extends BlocDemandeState {
final List<Invitation> invitation ;
  dataLoaded({required this.invitation}); 
 }
