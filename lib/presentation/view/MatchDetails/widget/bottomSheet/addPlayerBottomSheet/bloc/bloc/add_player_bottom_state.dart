part of 'add_player_bottom_bloc.dart';

@immutable
abstract class AddPlayerBottomState {}

class AddPlayerBottomInitial extends AddPlayerBottomState {}

class DataLoaded extends AddPlayerBottomState {
  final List<Player> players;
  DataLoaded({required this.players});
}
