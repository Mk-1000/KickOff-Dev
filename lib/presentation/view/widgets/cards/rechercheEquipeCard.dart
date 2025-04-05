import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';

class RechrcheEquipe extends StatefulWidget {
  final PositionSlot slot;
  final Team team;
  final bool send;
  const RechrcheEquipe({
    super.key,
    required this.send,
    required this.slot,
    required this.team,
  });

  @override
  State<RechrcheEquipe> createState() => _RechrcheEquipeState();
}

class _RechrcheEquipeState extends State<RechrcheEquipe> {
  late bool send;
  @override
  void initState() {
    send = widget.send;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 100.h,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).bottomAppBarTheme.color!, width: 2.w),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: Image.network(
                    "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                    height: 54.h,
                    width: 54.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.team.teamName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            width: 2.w,
            height: 100.h,
            color: Theme.of(context).bottomAppBarTheme.color!,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place_outlined, size: 16.sp),
                    Text(
                      "Monastir / MAY Foot Land",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, size: 16.sp),
                    Text(
                      "24 Jan 2024 / 23:00 H",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.directions_run, size: 16.sp),
                    Text(
                      widget.slot.position.name,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    const Icon(Icons.attach_money, size: 16),
                    Text(
                      "10 TND",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 47.h,
                child: SvgPicture.asset(
                  "assets/image/reserved.svg",
                ),
              ),
              SizedBox(
                height: 25.h,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color:
                          send ? Colors.white : Theme.of(context).primaryColor,
                      border: Border.all(
                        color: send
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: OutlinedButton(
                    onPressed: () async {
                      // Print for debugging purposes
                      print("this is the player id: ${Player.currentPlayer!.playerId}this is the team id:${widget.team.teamId}this is the slot id: ${widget.slot.slotId}");

                      // Ensure the widget is still mounted before proceeding
                      if (!mounted) return;

                      // Perform the asynchronous operation
                      await InvitationManager().sendInvitationFromPlayerToTeam(
                        playerId: Player.currentPlayer!.playerId,
                        teamId: widget.team.teamId,
                        slotId: widget.slot.slotId,
                      );

                      // Check again if the widget is mounted before updating state
                      if (!mounted) return;

                      // Update the state to toggle 'send'
                      setState(() => send = !send);
                    },

                    // style:
                    // send ? OutlinedButton.styleFrom(
                    //          primary: Theme.of(context).primaryColor,
                    //          side:  BorderSide(color: Theme.of(context).primaryColor),
                    //          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    //          backgroundColor: Colors.white,
                    //        ): ElevatedButton.styleFrom(
                    //   primary: Theme.of(context).primaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    // ),
                    child: Text(
                      send ? "Annuler" : "Envoyer",
                      style: TextStyle(
                        color: send
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
