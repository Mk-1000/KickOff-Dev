import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cards/notification.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AllText.Autotext(
            text: "Notification",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).shadowColor),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return NotificationCard();
              },
            )),
          ],
        ),
      ),
    );
  }
}
