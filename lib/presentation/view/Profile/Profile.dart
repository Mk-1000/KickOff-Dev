import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/presentation/view/Profile/widget/TopBar.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';



class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Widget Element(  IconData icon , String title ) {
      return  Container(
          margin: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
  // Icon(Icons.content_paste_rounded),
   Icon(icon),
  SizedBox(width: 8,),
            AllText.Autotext(text: title, fontSize: 18, fontWeight: FontWeight.w400, color: Theme.of(context).shadowColor)
            ],),
              Icon(Icons.arrow_forward_ios_outlined),

           ],),
         );
    }
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
         TopBar(), 
         SizedBox(height: 24,),
         Element(Icons.content_paste_rounded,"Historique"),
          Element(Icons.edit_calendar_outlined,"Editer le profil"),
           Element(Icons.settings_outlined,"Paramètres"),

        
          
         
        ],
      ),
    );
  }
}