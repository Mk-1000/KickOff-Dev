import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takwira/presentation/view/CreateTeam/bloc/bloc/team_event.dart';
import 'package:takwira/presentation/view/CreateTeam/bloc/bloc/team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc()
      : super(TeamState(numberOfTeams: 5, playersCount: {
          'Defender': 2,
          'Midfield': 1,
          'Attacker': 1,
        }));

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    if (event is IncrementTeamCount) {
      yield TeamState(
          numberOfTeams: state.numberOfTeams + 1,
          playersCount: state.playersCount);
    } else if (event is DecrementTeamCount) {
      yield TeamState(
          numberOfTeams: state.numberOfTeams - 1,
          playersCount: state.playersCount);
    } else if (event is IncrementPlayerCount) {
      final newCount = state.playersCount[event.position]! + 1;
      yield TeamState(
          numberOfTeams: state.numberOfTeams,
          playersCount: Map.from(state.playersCount)
            ..update(event.position, (value) => newCount));
    } else if (event is DecrementPlayerCount) {
      final newCount = state.playersCount[event.position]! - 1;
      yield TeamState(
          numberOfTeams: state.numberOfTeams,
          playersCount: Map.from(state.playersCount)
            ..update(event.position, (value) => newCount));
    }
  }
}
