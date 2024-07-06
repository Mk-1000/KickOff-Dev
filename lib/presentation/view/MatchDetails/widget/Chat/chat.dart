import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/Chat/widget/message.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/SendMesasge.dart';

class Chat extends StatefulWidget {
  final Team team;
  const Chat({super.key, required this.team});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatManager _chatManager = ChatManager();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatManager.getMessagesStream(widget.team.chatId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading messages'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages'));
                } else {
                  // Reverse the messages list here
                  final messages = snapshot.data!.reversed.toList();
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 16),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageUi(
                        content: messages[index].content,
                        imageUrl: "",
                        me: Player.currentPlayer!.playerId ==
                            messages[index].senderId,
                      );
                    },
                  );
                }
              },
            ),
          ),
          SendMessage(
            chatId: widget.team.chatId!,
          ),
        ],
      ),
    );
  }
}
