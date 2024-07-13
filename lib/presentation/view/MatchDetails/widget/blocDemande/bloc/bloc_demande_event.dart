part of 'bloc_demande_bloc.dart';

@immutable
abstract class BlocDemandeEvent {}
class loadData extends  BlocDemandeEvent{
  final Team team;
  loadData({required this.team});
}
