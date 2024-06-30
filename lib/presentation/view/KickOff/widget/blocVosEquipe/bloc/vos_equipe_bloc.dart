import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

part 'vos_equipe_event.dart';
part 'vos_equipe_state.dart';

class VosEquipeBloc extends Bloc<VosEquipeEvent, VosEquipeState> {
  VosEquipeBloc() : super(VosEquipeInitial()) {
    on<VosEquipeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<loadData>(load);
  }

  Future<FutureOr<void>> load(loadData event, Emitter<VosEquipeState> emit) async {
         List<Team> result =await TeamManager().getTeamsForPlayer(Player.currentPlayer!);
         emit(dataLoaded(teams: result)) ;
        
  }
}
