import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/button/sendButton/SendButton.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


class Vsview extends StatefulWidget {
    final bool invit ;
  const Vsview({super.key, required this.invit});

  @override
  State<Vsview> createState() => _VsviewState();
}

class _VsviewState extends State<Vsview> {
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
                colors: [Theme.of(context).primaryColor, const Color(0xFF0F297A)],
              ),
            ),
            // color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 46),
                  // margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      AllText.Autotext(
                          text: "Recherche d'adversaires",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      const SizedBox(width: 30,)
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 8,right: 24,left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Hero(
                          tag: "team_0",
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                            child: CahedImage(
                              img:
                                  "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                              height: 58,
                              width: 58,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          
                          ],
                        ),
                      ],
                    ),
                
                    const SendButton(invit: true,),
                  ],
                ),
              ),
            
               
           
               
                  const SizedBox(
                height: 16,
              ),
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
                              fontSize: 12,
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
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: Column(children: [
                    const Stade(defender: 1, mid: 1, attack: 1,),
                     Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Joueur",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                          width: 80,
                        child: AllText.Autotext(
                            text: "Position",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
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
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
   const Icon(Icons.block_rounded,color: Colors.grey,),
   const SizedBox(width: 8,),
                           AllText.Autotext(
                                  text: "Aucun",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                          ],),
                       
                         
                          SizedBox(
                              width: 80,
                            child: AllText.Autotext(
                                text: "Gardien",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(
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