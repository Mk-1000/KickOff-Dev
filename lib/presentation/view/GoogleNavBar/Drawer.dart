import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/Profile/Profile.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

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
              Icon(
                icon,
                color: text == "se déconnecter"
                    ? Colors.red
                    : Theme.of(context).shadowColor,
              ),
              SizedBox(
                width: 8.w,
              ),
              AllText.Autotext(
                text: text,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
                color: text == "se déconnecter"
                    ? Colors.red
                    : Theme.of(context).shadowColor,
              )
            ],
          ),
          Container(
              child: Icon(
            Icons.arrow_forward_ios,
            size: 15.sp,
            color: text == "se déconnecter"
                ? Colors.red
                : Theme.of(context).shadowColor,
          ))
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
        SizedBox(
          height: 105.h,
          child: DrawerHeader(
              decoration: const BoxDecoration(
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
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        child: Image.network(
                          "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      AllText.Autotext(
                          text: "test1",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).shadowColor)
                    ],
                  ),
                  AllText.Autotext(
                      text: "swolf712@gmail.com",
                      fontSize: 14.sp,
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
          title: itemSidebar("Contact us", Icons.mode_comment_outlined),
          onTap: () {},
        ),
        ListTile(
          title: itemSidebar("Share the app", Icons.share_outlined),
          onTap: () {},
        ),
        ListTile(
          title: itemSidebar("About kickoff", Icons.info_outline),
          onTap: () {},
        ),
        ListTile(
          title: itemSidebar("Privacy policy", Icons.security_outlined),
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
