import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';

part 'bloc_demande_event.dart';
part 'bloc_demande_state.dart';

class BlocDemandeBloc extends Bloc<BlocDemandeEvent, BlocDemandeState> {
  BlocDemandeBloc() : super(BlocDemandeInitial()) {
    on<BlocDemandeEvent>((event, emit) {
      // TODO: implement event handler
    });
        on<loadData>(load);
  }

  Future<FutureOr<void>> load(loadData event, Emitter<BlocDemandeState> emit) async {
      List<Invitation> result =   await InvitationManager().fetchReceivedInvitationsForTeam(event.team); 
      print(result);
      emit(dataLoaded(invitation: result)) ; 
  }
}
