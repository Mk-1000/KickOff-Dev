import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/button/sendButton/SendButton.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


class TeamView extends StatefulWidget {
  final bool invit ;
  const TeamView({super.key, required this.invit});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  late bool  send  ; 
  @override
  void initState() {
   send = widget.invit ; 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Container(
            height: 272,
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
                      SizedBox(width: 30,)
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
                          tag: "team_0",
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
               SendButton(invit: true,),
           
               
                  SizedBox(
                height: 16,
              ),
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
                ),
              // SizedBox(height: 8),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: Column(children: [
                    Stade(),
                     Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Joueur",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                          width: 80,
                        child: AllText.Autotext(
                            text: "Position",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                          width: 80,
                        child: AllText.Autotext(
                            text: "Numéro",
                            fontSize: 14,
                           fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                            
                    ],
                  ),
                ),
                       Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
   Icon(Icons.block_rounded,color: Colors.grey,),
   SizedBox(width: 8,),
                           AllText.Autotext(
                                  text: "Aucun",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                          ],),
                       
                         
                          Container(
                              width: 80,
                            child: AllText.Autotext(
                                text: "Gardien",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Container(
                              width: 80,
                            child: AllText.Autotext(
                                text: "1",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                       
                        ],
                      ),
                    );
                  },
                ))
                  ],)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}