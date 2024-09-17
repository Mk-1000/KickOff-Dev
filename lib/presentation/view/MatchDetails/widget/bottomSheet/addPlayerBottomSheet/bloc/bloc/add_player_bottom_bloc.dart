import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/bottomSheet/addPlayerBottomSheet/addPlayerBottomSheet.dart';

part 'add_player_bottom_event.dart';
part 'add_player_bottom_state.dart';

class AddPlayerBottomBloc
    extends Bloc<AddPlayerBottomEvent, AddPlayerBottomState> {
  AddPlayerBottomBloc() : super(AddPlayerBottomInitial()) {
    on<LoadData>(load);
  }
  Future<FutureOr<void>> load(
      LoadData event, Emitter<AddPlayerBottomState> emit) async {
    print("loadData event received"); // Debug print

    try {
      // Fetch players from the PlayerManager
      List<Player> result = await PlayerManager().getPlayers();
      print("Players loaded: ${result.length}"); // Debug print

      emit(DataLoaded(players: result)); // Emit the dataLoaded state
    } catch (e) {
      print("Error fetching players: $e"); // Catch any errors
      // Optionally, you could emit an error state here
    }
  }
}
