import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_player_bottom_event.dart';
part 'add_player_bottom_state.dart';

class AddPlayerBottomBloc extends Bloc<AddPlayerBottomEvent, AddPlayerBottomState> {
  AddPlayerBottomBloc() : super(AddPlayerBottomInitial()) {
    on<AddPlayerBottomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
