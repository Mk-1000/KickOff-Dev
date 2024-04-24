import 'package:flutter/material.dart';
import 'package:takwira/view/Calender/Calender.dart';
import 'package:takwira/view/GoogleNavBar/Navbar.dart';
import 'package:takwira/view/Notification/Notification.dart';
import 'package:takwira/view/widgets/text/text.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  HomeAppBar({
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () {
           GoogleNavBarState.scaffoldKey.currentState?.openDrawer();
          // Handle menu button action
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
              'URL_TO_YOUR_IMAGE', // Replace with your image URL
            ),
          ),
          SizedBox(width: 10), // For spacing
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // To align the column to the start
            children: <Widget>[
              AllText.Autotext(color: Theme.of(context).shadowColor, fontSize: 14, fontWeight: FontWeight.bold, text: 'Salut SWolf!'),
               AllText.Autotext(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal, text: 'lundi, 10 Janvier'),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.black),
              onPressed: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Calender()),
  );
                
                // Handle mail button action
              },
            ),
            Positioned(
              right: 11,
              top: 11,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const  NotificationMain()),
  );
               
                // Handle notifications button action
              },
            ),
            Positioned(
              right: 11,
              top: 11,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}