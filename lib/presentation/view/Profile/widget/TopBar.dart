import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 282,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor, Color(0xFF0F297A)],
              ),
            ),
            // color: Theme.of(context).primaryColor,
            child:  Container(
              margin:EdgeInsets.symmetric(horizontal: 24),
              child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 52),
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
                            text: "Profil",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                            SizedBox(width: 20,)
                      
                      ],
                    )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SvgPicture.asset(
  "assets/image/leftProfile.svg",
),
Column(children: [
  Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
              ),
              shape: BoxShape.circle,
          ),
          child: Stack(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 47.5 - 2,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: false
                          ? CachedNetworkImageProvider("")
                          : AssetImage('assets/placeholder.png') as ImageProvider,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 20.0,
                      ),
                    ),
                  ),
              ],
          ),
        ),
       SizedBox(height: 8,),
        AllText.Autotext(text: "SWolf", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)
],),
Container(
  height: 110,
  width: 2,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    color: Color(0xFFF5F5F5).withOpacity(0.6)
  ),
),
Column(children: [
  AllText.Autotext(text: "Position", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
 SizedBox(height: 18,),
  Row(children: [
    Container(
      height: 40,
      width: 40,
      child: ClipRRect(
        borderRadius:BorderRadius.all(Radius.circular(20)),
        child: Image.asset("assets/image/0.png"),
      ),
    ),
    SizedBox(width: 8,),
    AllText.Autotext(text: "Attaquant", fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)
   
  ],)
],),
 SvgPicture.asset(
  "assets/image/rigthProfile.svg",
),
                 ],),
                 SizedBox(height: 32,),
            SvgPicture.asset(
  "assets/image/bottomProfile.svg",
),
              ],
          ),
            ),
          );
  }
}