part of 'add_player_bottom_bloc.dart';

@immutable
abstract class AddPlayerBottomEvent {}

class LoadData extends AddPlayerBottomEvent {}

class sendInvitation extends AddPlayerBottomEvent {}
