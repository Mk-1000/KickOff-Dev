import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onbording_event.dart';
part 'onbording_state.dart';

class OnbordingBloc extends Bloc<OnbordingEvent, OnbordingState> {
  OnbordingBloc() : super(OnbordingInitial(0,"assets/image/onbording1.png",'Vous voulez améliorer encore votre meilleur jeu ?','Kawer est la première application pour gérer votre équipe et réserver vos places.')) {
    on<OnbordingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<changePage>(changepg) ;
    on<retour>(retourpage) ;
  }

  FutureOr<void> changepg(changePage event, Emitter<OnbordingState> emit) {
   int  page = event.page ; 
    if(event.page  == 0 ) {
       page ++ ; 
           emit(OnbordingInitial(page,"assets/image/onbording2.png",'Créez votre propre équipe ou participez à une autre','Vous pouvez organiser votre propre équipe ou rejoindre une équipe existante.')) ; 
    }else if (page == 1) {
        page ++ ; 
                   emit(OnbordingInitial(page,"assets/image/onbording3.png",'Planifiez la réservation de votre terrain.','Notre application rend la réservation de terrains plus simple et plus facile.')) ; 

    }else if (page == 2) {
        page ++ ; 
                   emit(OnbordingInitial(page,"assets/image/onbording4.png",'Une sensation Professionnelle incomparable','Notre appli offre une expérience pro avec arbitre et dossards personnalisés, et plus...')) ; 
            }else if (page == 3) {
        
    }
  }

  FutureOr<void> retourpage(retour event, Emitter<OnbordingState> emit) {
    int page  = event.page ; 
    if(page > 0 ) {
    page-- ; 
    }
        if(page  == 0 ) {
                     emit(OnbordingInitial(0,"assets/image/onbording1.png",'Vous voulez améliorer encore votre meilleur jeu ?','Kawer est la première application pour gérer votre équipe et réserver vos places.')) ; 

    }else if (page == 1) {
                 emit(OnbordingInitial(page,"assets/image/onbording2.png",'Créez votre propre équipe ou participez à une autre','Vous pouvez organiser votre propre équipe ou rejoindre une équipe existante.')) ; 

    }else if (page == 2) {
                         emit(OnbordingInitial(page,"assets/image/onbording3.png",'Planifiez la réservation de votre terrain.','Notre application rend la réservation de terrains plus simple et plus facile.')) ; 
            }else if (page == 3) {
        
    }
  }
}
