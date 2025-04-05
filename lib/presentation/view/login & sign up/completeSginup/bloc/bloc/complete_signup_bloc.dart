import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'complete_signup_event.dart';
part 'complete_signup_state.dart';

class CompleteSignupBloc
    extends Bloc<CompleteSignupEvent, CompleteSignupState> {
  CompleteSignupBloc() : super(CompleteSignupInitial(0)) {
    on<changePage>(changepg);
    on<retour>(retourpage);
  }

  FutureOr<void> changepg(changePage event, Emitter<CompleteSignupState> emit) {
    int page = event.page;

    // Passage à la page suivante
    if (page >= 0 && page < 3) {
      page++; // Incrémente la page pour aller à la page suivante
    }

    // Émettre l'état mis à jour avec la nouvelle page
    emit(CompleteSignupInitial(page));
  }

  FutureOr<void> retourpage(retour event, Emitter<CompleteSignupState> emit) {
    int page = event.page;

    if (page == 0) {
      // Cela permet de fermer l'écran actuel et revenir à l'écran précédent
      Navigator.pop(event.context); // Nous devons envoyer le `context` ici
    } else {
      page--; // Décrémenter la page pour revenir à la page précédente
    }

    // Émettre l'état mis à jour avec la page précédente
    emit(CompleteSignupInitial(page));
  }
}
