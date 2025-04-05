import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/Calender/Calender.dart';
import 'package:takwira/presentation/view/GoogleNavBar/Navbar.dart';
import 'package:takwira/presentation/view/Notification/Notification.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const HomeAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0, // Removes the shadow
      backgroundColor: Colors.white,
      shape: const Border(
        bottom: BorderSide.none, // Removes the line under the AppBar
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          GoogleNavBarState.scaffoldKey.currentState?.openDrawer();
          // Handle menu button action
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'URL_TO_YOUR_IMAGE', // Replace with your image URL
            ),
          ),
          SizedBox(width: 10.w), // For spacing
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // To align the column to the start
            children: <Widget>[
              AllText.Autotext(
                  color: Theme.of(context).shadowColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  text: 'Salut SWolf!'),
              AllText.Autotext(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  text: 'lundi, 10 Janvier'),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 26.sp,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Calender()),
                );

                // Handle mail button action
              },
            ),
            Positioned(
              right: 5.w,
              top: 9.h,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
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
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 26.sp,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationMain()),
                );

                // Handle notifications button action
              },
            ),
            Positioned(
              right: 11.w,
              top: 8.h,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
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
