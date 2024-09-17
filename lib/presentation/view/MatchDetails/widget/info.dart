import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/bottomSheet/addPlayerBottomSheet/addPlayerBottomSheet.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class Info extends StatefulWidget {
  final Team team;
  const Info({super.key, required this.team});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Stade(
            defender: widget.team.maxDefenders,
            mid: widget.team.maxMidfielders,
            attack: widget.team.maxForwards,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Theme.of(context).primaryColor),
            //     borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80.w,
                        child: AllText.Autotext(
                            text: "Joueur",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 80.w,
                        child: AllText.Autotext(
                            text: "Position",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 80.w,
                        child: AllText.Autotext(
                            text: "Numéro",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 70.w,
                        child: AllText.Autotext(
                            text: "Action",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(top: 8.h),
                  itemCount: widget.team.slots.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F3FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            width: 80.w,
                            height: 32.h,
                            child: Row(children: [
                              Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AllBottomSheet().FunBottomSheet(
                                      context,
                                      addPlayerBottomSheet(
                                        slotID: widget.team.slots[index].slotId,
                                        teamID: widget.team.teamId,
                                        publique: false,
                                      ));
                                },
                                child: AllText.Autotext(
                                    text: "Ajouter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).shadowColor),
                              )
                            ]),
                          ),
                          Container(
                            width: 80.w,
                            child: AllText.Autotext(
                                text: widget.team.slots![index].position.name,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Container(
                            width: 80.w,
                            child: AllText.Autotext(
                                text:
                                    widget.team.slots![index].number.toString(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Container(
                              width: 70.w, child: Icon(Icons.more_vert_rounded))
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
