import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takwira/view/Onbording/Onbording.dart';
import 'package:takwira/view/Onbording/bloc/bloc/onbording_bloc.dart';
import 'package:takwira/view/login%20&%20sign%20up/login.dart';

class Body extends StatelessWidget {
  final String img;
  final String title;
  final String text;
  final int postion;
  const Body(
      {super.key,
      required this.img,
      required this.title,
      required this.text,
      required this.postion});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 26),
          child:
           Image.asset(
            img,
            height: 287,
            width: 287,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 32),
          child: AutoSizeText(
            textAlign: TextAlign.center,
            title,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: AutoSizeText(
            textAlign: TextAlign.center,
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  height: 1.4,
                  color: Color(0xFF6D7289),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 4; i++) ...{
              Container(
                decoration: BoxDecoration(
                  color: postion == i  ?Color(0xFF3053EC):  Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(left: 4, right: 4, top: 24),
                height: 10,
                width: 10,
              ),
            }
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * 0.06),
          child: 
           Row(
            mainAxisAlignment: postion == 0 ? MainAxisAlignment.end :MainAxisAlignment.spaceBetween  ,
            children: [
              if(postion == 0 ) ...{
                 GestureDetector(
                onTap: () {
                  if(postion<2) {
   OnbordingStat.TypeSwitcher.add(changePage(postion)) ; 
                  }else {
                     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Login()),
  );
                  }
               
                },
                child:Container(
                height: 48,
                width: 115,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF3053EC),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  "Suivant",
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(height: 1.4, color: Colors.white),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ) ,)
              }else ...{
                 GestureDetector(
                onTap: () {
                // Navigator.pop(context); 
                 OnbordingStat.TypeSwitcher.add(retour(postion)) ; 
                },
                child:Container(
                height: 48,
                width: 115,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFF3053EC)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(48),
                ),
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  "Retour",
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(height: 1.4, color: Color(0xFF3053EC)),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ) ,),
                 GestureDetector(
                onTap: () {
                   if(postion<2) {
   OnbordingStat.TypeSwitcher.add(changePage(postion)) ; 
                  }else {
                     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Login()),
  );
                  }
                  // OnbordingStat.TypeSwitcher.add(changePage(postion)) ; 
                },
                child:Container(
                height: 48,
                width: 115,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF3053EC),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  "Suivant",
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(height: 1.4, color: Colors.white),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ) 
              ,)
              }
             
              
            ],
          ),
        )
      ],
    );
  }
}
