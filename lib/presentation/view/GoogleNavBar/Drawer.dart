import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

import '../Profile/Profile.dart';


class Drawers extends StatefulWidget {
  const Drawers({super.key});

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  Widget build(BuildContext context) {
    Widget itemSidebar(String text, IconData icon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: text == "se déconnecter" ? Colors.red:Theme.of(context).shadowColor,),
              SizedBox(width:8,),
              AllText.Autotext(
                  text: text,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color:  text == "se déconnecter" ? Colors.red:Theme.of(context).shadowColor,)
            ],
          ),
       Container(child: Icon(Icons.arrow_forward_ios, size: 15, color: text == "se déconnecter" ? Colors.red:Theme.of(context).shadowColor,))
//         if( text == AppLocalizations.of(context)!.darkMode)...{
//          DarkMode()
//         }else ...{
// Container(child: Icon(Icons.arrow_forward_ios, size: 15,color: Account().darkmod ?Colors.white:Colors.black,))
//         },
        ],
      );
    }

    return Drawer(
        // backgroundColor: Colors.white,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            Container(
              height: 110,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // color: Colors.amber
                ),
                // margin: EdgeInsets.zero,
                // padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        child: Image.network(
                          "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8,),
                      AllText.Autotext(
                          text: "test1",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor)
                    ],
                  ),
                  AllText.Autotext(
                      text: "swolf712@gmail.com",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)
                ],
              )),
            ),
            ListTile(
              title: itemSidebar("Profile", Icons.person_outline),
              onTap: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Profile()),
  );
              },
            ),
                        ListTile(
              title: itemSidebar("Historique", Icons.content_paste),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("Dark Mode", Icons.dark_mode_outlined),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("Settings", Icons.settings_outlined),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("contact us", Icons.mode_comment_outlined),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("share the app", Icons.share_outlined ),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("about kickoff", Icons.info_outline),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("privacy policy", Icons.security_outlined),
              onTap: () {},
            ),
                        ListTile(
              title: itemSidebar("se déconnecter", Icons.logout_outlined),
              onTap: () {},
            ),

            // Add more items as needed
          ],
        ));
  }
}
