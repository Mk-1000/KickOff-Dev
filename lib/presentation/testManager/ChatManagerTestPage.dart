import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/presentation/Managers/ChatManager.dart';

class ChatManagerTestPage extends StatefulWidget {
  @override
  _ChatManagerTestPageState createState() => _ChatManagerTestPageState();
}

class _ChatManagerTestPageState extends State<ChatManagerTestPage> {
  final ChatManager _chatManager = ChatManager();

  String _resultMessage = '';

  Future<void> _testGetChatDetails() async {
    try {
      Chat? chat = await _chatManager
          .getChatDetails('4e322495-f5d9-4cd0-b854-180c8a5434c9');
      setState(() {
        _resultMessage = 'Chat Details: $chat';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Error: $e';
      });
    }
  }

  Future<void> _testCreateNewChat() async {
    try {
      // Initialize ChatManager instance
      ChatManager _chatManager = ChatManager();

      Chat chat = Chat(
        participants: {'user_id': true},
        lastMessageId: '',
        lastMessageReadReceipts: {},
        messages: [],
        type: 'private',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      Message initialMessage = Message(
        senderId: 'user_id',
        content: 'Hello, world!',
        sendDate: DateTime.now(),
        chatId: chat.chatId,
      );

      // Call createNewChat method
      await _chatManager.createNewChat(chat, initialMessage, 'participant_id');
      // Assuming setState is available within a Flutter widget context
      setState(() {
        _resultMessage = 'New chat created successfully';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Error: $e';
      });
    }
  }

  // Implement methods to test other functionalities similarly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Manager Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _testGetChatDetails,
              child: Text('Test Get Chat Details'),
            ),
            ElevatedButton(
              onPressed: _testCreateNewChat,
              child: Text('Test Create New Chat'),
            ),
            // Add buttons for other test methods here
            SizedBox(height: 20),
            Text(
              _resultMessage,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
