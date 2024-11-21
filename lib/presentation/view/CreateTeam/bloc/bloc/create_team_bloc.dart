import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_team_event.dart';
part 'create_team_state.dart';

class CreateTeamBloc extends Bloc<CreateTeamEvent, CreateTeamState> {
  int attack = 3;
  int midle = 1;
  int defender =2;
  CreateTeamBloc()
      : super(CreateTeamInitial(attacker: 3, midle: 1, defender: 2)) {
    on<CreateTeamEvent>((event, emit) {
      // TODO: implement event handler
    });
      on<Incrment>(icrement);
      on<Decrement>(decriment);
  }

  FutureOr<void> icrement(Incrment event, Emitter<CreateTeamState> emit) {
    if (event.titre == 'Attaquant' && attack < 4) {
      attack++;
    } else if (event.titre =='Milieu' && midle < 4) {
      midle++;
    } else if (event.titre == 'Défenseur' && defender < 4) {
      defender++;
    }
    emit(CreateTeamInitial(attacker: attack , defender: defender, midle: midle));
  }

  FutureOr<void> decriment(Decrement event, Emitter<CreateTeamState> emit) {

    if (event.titre == 'Attaquant' && attack > 1 && ((attack+midle +defender ) > 5))  {
      attack--;
    } else if (event.titre =='Milieu' && midle > 1 && ((attack+midle +defender ) > 5)) {
      midle--;
    } else if (event.titre == 'Défenseur' && defender > 1 && ((attack+midle +defender ) > 5)) {
      defender--;
    }
    emit(CreateTeamInitial(attacker: attack , defender: defender, midle: midle));
  }
}
