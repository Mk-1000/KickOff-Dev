import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/AddressManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/bottomSheet/addPlayerBottomSheet/addPlayerBottomSheet.dart';

part 'add_player_bottom_event.dart';
part 'add_player_bottom_state.dart';

class AddPlayerBottomBloc
    extends Bloc<AddPlayerBottomEvent, AddPlayerBottomState> {
  AddPlayerBottomBloc() : super(AddPlayerBottomInitial(players: [])) {
    on<LoadData>(load);
  }

  Future<FutureOr<void>> load(
      LoadData event, Emitter<AddPlayerBottomState> emit) async {
    print("loadData event received"); // Debug print

    try {
      List<Player> result = [];
      List<Address> playerAdress = [];
      emit(IsLoading());
      // Fetch players from the PlayerManager
      Team team = await TeamManager().getTeamById(event.teamId);
      List<Player> availablePlayers = [];
      await PlayerManager().getPlayers().then((value) async {
        availablePlayers = value
            .where((player) => !team.players.contains(player.playerId))
            .toList();
        result = value;
      });
      for (var element in availablePlayers) {
        var adresse =
            await AddressManager().getAddressDetails(element.addressId!);
        playerAdress.add(adresse);
      }
      if (result.isNotEmpty)
        print("Players loaded: ${result.length}"); // Debug print

      emit(DataLoaded(
          players: availablePlayers,
          adresse: playerAdress)); // Emit the dataLoaded state
    } catch (e) {
      print("Error fetching players: $e"); // Catch any errors
      // Optionally, you could emit an error state here
    }
  }

  @override
  void onTransition(
      Transition<AddPlayerBottomEvent, AddPlayerBottomState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  @override
  void onChange(Change<AddPlayerBottomState> change) {
    // TODO: implement onChange
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }

  @override
  void onEvent(AddPlayerBottomEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
  }
}
