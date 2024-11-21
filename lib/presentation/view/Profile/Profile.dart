import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            text: "Constituez votre équipe",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).shadowColor),
      ),
    );
  }
}
