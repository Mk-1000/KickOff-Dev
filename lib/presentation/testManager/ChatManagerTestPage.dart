import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';

class ChatManagerTestPage extends StatefulWidget {
  @override
  _ChatManagerTestPageState createState() => _ChatManagerTestPageState();
}

class _ChatManagerTestPageState extends State<ChatManagerTestPage> {
  final ChatManager _chatManager = ChatManager();
  late Chat _chat;
  late Message _initialMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    _chat = Chat(
      participants: [],
      type: ChatType.private,
      messages: [],
    );
    _initialMessage = Message(
      messageId: 'initial_msg_id',
      content: "Welcome to the chat!",
      senderId: "user_123",
      sendDate: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await _chatManager.createNewChat(_chat, _initialMessage, "user_123");
      _chat = (await _chatManager.getChatDetails(_chat.chatId))!;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error initializing chat: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addNewParticipant() async {
    try {
      await _chatManager.addNewPlayerToChat(_chat.chatId, "new_user");
      _chat = (await _chatManager.getChatDetails(_chat.chatId))!;
      setState(() {});
    } catch (e) {
      print("Error adding new participant: $e");
    }
  }

  Future<void> _addNewMessage() async {
    try {
      Message newMessage = Message(
        messageId: 'new_msg_id',
        content: "Hello everyone!",
        senderId: "new_user",
        sendDate: DateTime.now().millisecondsSinceEpoch,
      );
      await _chatManager.addNewMessageToChat(_chat.chatId, newMessage);
      _chat = (await _chatManager.getChatDetails(_chat.chatId))!;
      setState(() {});
    } catch (e) {
      print("Error adding new message: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Manager Test Page"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Chat ID: ${_chat.chatId}"),
                  Text("Participants: ${_chat.participants.join(", ")}"),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _chat.messages.length,
                      itemBuilder: (context, index) {
                        final message = _chat.messages[index];
                        return ListTile(
                          title: Text(message.content),
                          subtitle: Text("Sent by: ${message.senderId}"),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addNewParticipant,
                    child: Text("Add New Participant"),
                  ),
                  ElevatedButton(
                    onPressed: _addNewMessage,
                    child: Text("Add New Message"),
                  ),
                ],
              ),
            ),
    );
  }
}
