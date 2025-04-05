import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/cards/rechercheEquipeCard.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';

class RechercheEquipe extends StatefulWidget {
  const RechercheEquipe({Key? key}) : super(key: key);

  @override
  State<RechercheEquipe> createState() => _RechercheEquipeState();
}

class _RechercheEquipeState extends State<RechercheEquipe> {
  final TextEditingController searchController = TextEditingController();
  static const int itemCount = 10;
  final TeamManager teamManager = TeamManager();
  List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSearchBar(),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropDuwnButton(
              list: postion,
            ),
            DropDuwnButton(
              list: ville,
            ),
          ],
        ),
        Expanded(
          child: _buildAnimatedListView(),
        )
      ],
    );
  }

  Widget _buildAnimatedSearchBar() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
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

  Widget _buildAnimatedListView() {
    return StreamBuilder<List<PositionSlot>>(
      stream: teamManager.getPublicAvailableSlotsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No available slots found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PositionSlot slot = snapshot.data![index];

              // Use FutureBuilder to asynchronously fetch team details
              return FutureBuilder<Team>(
                future: teamManager.getTeamById(slot.teamId),
                builder: (context, teamSnapshot) {
                  if (teamSnapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                        "null team fetched"); // Placeholder until team details are fetched
                  } else if (teamSnapshot.hasError) {
                    return Text("error1${teamSnapshot.error}"); // Handle error case
                  } else if (!teamSnapshot.hasData) {
                    return const Text("no team"); // No team found case
                  } else {
                    Team team = teamSnapshot.data!;
                    return _buildSlideFromBottomCard(index, team, slot);
                  }
                },
              );
            },
          );

          //         ListView.builder(
          //   padding: const EdgeInsets.only(top: 8, bottom: 16),
          //   itemCount: snapshot.data!.length,
          //   itemBuilder: (context, index) {
          //        PositionSlot slot = snapshot.data![index];
          //     return  _buildSlideFromBottomCard(index , slot);

          //   },
          // );
        }
      },
    );
  }

  Widget _buildSlideFromBottomCard(int index, Team team, PositionSlot slot) {
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
        child: RechrcheEquipe(
          team: team,
          send: false,
          slot: slot,
        )
        //  const VosEquipeCard(
        //   name: 'WaaBroo',
        //   photo: 'https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg',
        //   place: 'Monastir',
        //    captine: true, postion: 'Milieu',
        // ),
        );
  }
}
