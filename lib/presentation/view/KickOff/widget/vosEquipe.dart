import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/KickOff/widget/blocVosEquipe/bloc/vos_equipe_bloc.dart';
import 'package:takwira/presentation/view/MatchDetails/MatchDetail.dart';
import 'package:takwira/presentation/view/widgets/cards/vosEquipeCards.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';

class VosEquipe extends StatefulWidget {
  const VosEquipe({Key? key}) : super(key: key);
    static VosEquipeBloc VosEquipeController = VosEquipeBloc();

  @override
  State<VosEquipe> createState() => _VosEquipeState();
}

class _VosEquipeState extends State<VosEquipe> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    //TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     VosEquipe. VosEquipeController.add(loadData());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSearchBar(),
        BlocBuilder<VosEquipeBloc, VosEquipeState>(
            bloc: VosEquipe.VosEquipeController,
            builder: (context, state) {
              if (state is VosEquipeInitial) {
                return Container();
              } else if (state is dataLoaded) {
                return Expanded(
                  child: _buildAnimatedListView(state.teams),
                );
              }

              return Container();
            }),
      ],
    );
  }

  Widget _buildAnimatedSearchBar() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Search(controller: searchController, hint: 'Recherche'),
    );
  }

  Widget _buildAnimatedListView(List<Team> teams) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: teams.length,
      itemBuilder: (context, index) {
      //  TeamManager().updateSlotStatusToPublic(teams[index].teamId,teams[index].slots[2].slotId);
        return _buildSlideFromBottomCard(index ,teams);
      },
    );
  }

  Widget _buildSlideFromBottomCard(int index , List<Team> teams) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + index * 200),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 1, end: 0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * value),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MatchDetails(team: teams[index],)),
          );
        },
        child: VosEquipeCard(
          name: teams[index].teamName,
          photo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB7nXgavBhOElhzqVmf-9fI-j4n9K6LPplzuG7M3y0jA&s',
          place: 'Monastir, Tunisia',
          captine: Player.currentPlayer!.playerId == teams[index].captainId,
          postion: teams[index].getPlayerPosition(Player.currentPlayer!.playerId)!,
          id: teams[index].teamId ,
        ),
      ),
    );
  }
}
