import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takwira/presentation/view/CreateTeam/widget/CircleNumber.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/Chat/chat.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/demande.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/info.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({super.key});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  int page = 0;
  bool dateReserved = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 247,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor, Color(0xFF0F297A)],
              ),
            ),
            // color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 46),
                  // margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon:
                            Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      AllText.Autotext(
                          text: "test1",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      IconButton(
                        icon: Icon(
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
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: "id_0",
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: CahedImage(
                              img:
                                  "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                              height: 58,
                              width: 58,
                              box: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AllText.Autotext(
                                text: "Waabro",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            AllText.Autotext(
                                text: "Monastir",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                    AllText.Autotext(
                        text: "VS",
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AllText.Autotext(
                                text: "Waabro",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            AllText.Autotext(
                                text: "Monastir",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: CahedImage(
                            img:
                                "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                            height: 58,
                            width: 58,
                            box: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              if (dateReserved) ...{
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            color: Colors.white,
                          ),
                          AllText.Autotext(
                              text: "May foot land, Monastir",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          ),
                          AllText.Autotext(
                              text: "24 Jan 2024 10:30h ",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)
                        ],
                      )
                    ],
                  ),
                )
              } else ...{
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 108,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: AllText.Autotext(
                      text: "Date & Stade",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
              },
              SizedBox(height: 8),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      labelStyle: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
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
                      Info(), // Make sure these widgets exist and are imported
                      Chat(),
                      Demande(),
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
