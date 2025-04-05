import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/GameManager.dart';
import 'package:takwira/presentation/view/Extensions/widget_extensions.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/Chat/chat.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/bottomSheet/selectDateBottomSheet.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/demande.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/info.dart';
import 'package:takwira/presentation/view/widgets/bottomSheet/AllButtomSheet.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

import '../SearchOponent/searchOponent.dart';

class MatchDetails extends StatefulWidget {
  final Team team;

  const MatchDetails({super.key, required this.team});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  int page = 0;
  bool dateReserved = false;
  DateTime? _selectedDate;

  final GameManager _gameManager = GameManager();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? now),
      );
      if (pickedTime != null) {
        final pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          _selectedDate = pickedDateTime;
        });
        try {
          /* await _gameManager.updateGameDate(widget.gameId, pickedDateTime); 
          setState(() {
            _gameFuture = _loadGame();
          });*/
        } catch (e) {
          debugPrint('Error updating game date: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 247.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  const Color(0xFF0F297A)
                ],
              ),
            ),
            // color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 46.h),
                  // margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      AllText.Autotext(
                          text: widget.team.teamName,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Add your action here
                          print('Settings button pressed');
                        },
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: widget.team.teamId,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                            child: CahedImage(
                              img:
                                  "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                              height: 58.h,
                              width: 58.w,
                              box: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AllText.Autotext(
                                text: "Waabro",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            AllText.Autotext(
                                text: "Monastir",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                    AllText.Autotext(
                        text: "VS",
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchOponent()),
                        );
                      },
                      child: Row(
                        children: [
                          Column(
                            children: [
                              AllText.Autotext(
                                  text: "Recherche ",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              AllText.Autotext(
                                  text: "d'equipe",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ],
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              child: Container(
                                height: 58.h,
                                width: 58.w,
                                color: Colors.white,
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.question,
                                    color: Theme.of(context).primaryColor,
                                    size: 40.sp,
                                    weight: 20.w,
                                  ),
                                ),
                              )).onTap(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              if (_selectedDate != null) ...{
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            color: Colors.white,
                          ),
                          AllText.Autotext(
                              text: "May foot land, Monastir",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          ),
                          AllText.Autotext(
                              text: "24 Jan 2024 10:30h ",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)
                        ],
                      )
                    ],
                  ),
                )
              } else ...{
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 130.w,
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: AllText.Autotext(
                            text: "Recherche Stade",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      ).onTap(
                          onTap: (() => AllBottomSheet().FunBottomSheet(
                              context, const selectDateBottomSheet()))),
                      Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 150.w,
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: AllText.Autotext(
                            text: "Selectioner une Date",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      ).onTap(onTap: () => _selectDateTime(context)),
                    ],
                  ),
                )
              },
              SizedBox(height: 8.h),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.r),
                          topLeft: Radius.circular(16.r))),
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      labelStyle: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.normal),
                      ),
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.grey,
                    ),
                    tabs: const [
                      Text("Info"),
                      Text("Discussions"),
                      Text("Demandes"),
                    ],
                    views: [
                      Info(
                        team: widget.team,
                      ), // Make sure these widgets exist and are imported
                      Chat(
                        team: widget.team,
                      ),
                      Demande(
                        team: widget.team,
                      ),
                    ],
                    onChange: (index) => print('Selected index: $index'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
