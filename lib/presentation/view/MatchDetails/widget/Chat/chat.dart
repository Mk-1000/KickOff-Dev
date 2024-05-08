import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/Chat/widget/message.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/SendMesasge.dart';



class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            reverse: true,
  itemCount: 6,
  itemBuilder: (context, index) {
    return Message(imageUrl: "",me: true,);
  },
)
        ),
        SendMessage(),
      ],),
    );
  }
}