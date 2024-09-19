import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/KickOff/widget/blocVosEquipe/bloc/vos_equipe_bloc.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/bottomSheet/addPlayerBottomSheet/bloc/bloc/add_player_bottom_bloc.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/cards/invitCard.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class addPlayerBottomSheet extends StatefulWidget {
  final String teamID;
  final String slotID;
  bool publique;
  addPlayerBottomSheet(
      {super.key,
      required this.teamID,
      required this.slotID,
      required this.publique});
  static AddPlayerBottomBloc addPlayerBottomController = AddPlayerBottomBloc();

  @override
  State<addPlayerBottomSheet> createState() => _addPlayerBottomSheetState();
}

class _addPlayerBottomSheetState extends State<addPlayerBottomSheet> {
  bool gratuit = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    // Perform the async work here
    addPlayerBottomSheet.addPlayerBottomController.add(LoadData());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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

    List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
    List<String> ville = ["Monastir"];
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 30.sp,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.w, right: 29.w),
                  alignment: Alignment.center,
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: AllText.Autotext(
                      text: "1",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                    alignment: Alignment.center,
                    child: AllText.Autotext(
                        text: "Gardien",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).shadowColor)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30.sp,
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AllText.Autotext(
                    text: "publique",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                Switch(
                    value: widget.publique,
                    onChanged: (value) {
                      if (value) {
                        TeamManager().updateSlotStatusToPublic(
                            widget.teamID, widget.slotID);
                      } else {
                        TeamManager().updateSlotStatusToPrivate(
                            widget.teamID, widget.slotID);
                      }
                      setState(() {
                        widget.publique = !widget.publique;
                      });
                    }),
                AllText.Autotext(
                    text: "Gratuitement",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                Switch(
                    value: gratuit,
                    onChanged: (value) {
                      setState(() {
                        gratuit = !gratuit;
                      });
                    })
              ],
            ),
            _buildAnimatedSearchBar(),
            SizedBox(
              height: 12.h,
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
            //         BlocBuilder<VosEquipeBloc, VosEquipeState>(
            // bloc: VosEquipe.VosEquipeController,
            // builder: (context, state) {
            //   if (state is VosEquipeInitial) {
            //     return Container();
            //   } else if (state is dataLoaded) {
            //     return Expanded(
            //       child: _buildAnimatedListView(state.teams),
            //     );
            //   }

            //   return Container();
            // }),

            BlocBuilder<AddPlayerBottomBloc, AddPlayerBottomState>(
                bloc: addPlayerBottomSheet.addPlayerBottomController,
                builder: (context, state) {
                  if (state is IsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DataLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        itemCount: state.players.length,
                        itemBuilder: (context, index) {
                          //TeamManager().updateSlotStatusToPublic(teams[index].teamId,teams[index].slots[2].slotId);
                          return Padding(
                            padding: EdgeInsets.all(5.h),
                            child: InvitCard(
                              player: Player(
                                  email: state.players[index].email,
                                  nickname: state.players[index].nickname,
                                  birthdate: state.players[index].birthdate,
                                  addressId: state.adresse[index].city,
                                  preferredPosition:
                                      state.players[index].preferredPosition,
                                  phoneNumber: state.players[index].phoneNumber,
                                  jerseySize: state.players[index].jerseySize),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text("Something went wrong!"));
                  }
                })
          ],
        ),
      ),
    );
  }
}
