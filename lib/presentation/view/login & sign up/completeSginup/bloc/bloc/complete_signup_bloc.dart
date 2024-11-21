import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complete_signup_event.dart';
part 'complete_signup_state.dart';

class CompleteSignupBloc extends Bloc<CompleteSignupEvent, CompleteSignupState> {
  CompleteSignupBloc() : super(CompleteSignupInitial(0)) {
    on<CompleteSignupEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<changePage>(changepg) ;
    on<retour>(retourpage) ;
  }

  FutureOr<void> changepg(changePage event, Emitter<CompleteSignupState> emit) {
      int page = event.page ; 
    if(event.page == 0 ) {
page++ ; 
emit(CompleteSignupInitial(page)) ; 
    }else if (event.page == 1 ) {
page++ ; 
emit(CompleteSignupInitial(page)) ; 
    }else if (event.page == 2 ) {
      page++ ; 
emit(CompleteSignupInitial(page)) ; 
    }else if (event.page == 3 ) {
      
    }
  }

  FutureOr<void> retourpage(retour event, Emitter<CompleteSignupState> emit) {
          int page = event.page ; 
    if(event.page == 0 ) {

    }else if (event.page == 1 ) {
page-- ; 
emit(CompleteSignupInitial(page)) ; 
    }else if (event.page == 2 ) {
    page-- ; 
emit(CompleteSignupInitial(page)) ; 
    }else if (event.page == 3 ) {
       page-- ; 
emit(CompleteSignupInitial(page)) ; 
    }
  }
}
