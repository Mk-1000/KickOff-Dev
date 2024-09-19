part of 'add_player_bottom_bloc.dart';

@immutable
abstract class AddPlayerBottomEvent {}

class LoadData extends AddPlayerBottomEvent {
  String teamId;
  LoadData({required this.teamId});
}

class sendInvitation extends AddPlayerBottomEvent {}
