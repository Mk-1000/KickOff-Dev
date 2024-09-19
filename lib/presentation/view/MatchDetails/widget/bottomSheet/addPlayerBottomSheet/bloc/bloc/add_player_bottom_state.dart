part of 'add_player_bottom_bloc.dart';

@immutable
abstract class AddPlayerBottomState {}

class AddPlayerBottomInitial extends AddPlayerBottomState {
  final List<Player> players;
  AddPlayerBottomInitial({required this.players});
}

class IsLoading extends AddPlayerBottomState {}

class DataLoaded extends AddPlayerBottomState {
  final List<Player> players;
  final List<Address> adresse;
  DataLoaded({required this.players, required this.adresse});
}
