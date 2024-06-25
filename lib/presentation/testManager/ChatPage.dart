import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takwira/domain/entities/Chat.dart';
import 'package:takwira/domain/entities/Message.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';

class ChatPage extends StatefulWidget {
  final String chatId;

  ChatPage({Key? key, required this.chatId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatManager _chatManager = ChatManager();
  final TextEditingController _messageController = TextEditingController();
  Chat? chat;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchChat();
  }

  Future<void> _fetchChat() async {
    try {
      chat = await _chatManager.getChatDetails(widget.chatId);
      print('Chat details loaded: ${chat?.toJson()}');
    } catch (e) {
      errorMessage = 'Failed to load chat details';
      print(errorMessage);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _sendMessage(String messageText) async {
    try {
      await _chatManager.sendMessage(widget.chatId, messageText);
      _messageController.clear();
      print('Message sent: $messageText');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message')),
      );
      print('Failed to send message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat != null ? chat!.chatId : 'Chat Details'),
      ),
      body: isLoading
          ? _buildLoadingUI()
          : (errorMessage != null ? _buildErrorUI() : _buildChatUI()),
    );
  }

  Widget _buildChatUI() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Message>>(
            stream: _chatManager.getMessagesStream(widget.chatId),
            builder: (context, snapshot) {
              print('Stream snapshot state: ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Stream snapshot error: ${snapshot.error}');
                return Center(child: Text('Error loading messages'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print('Stream snapshot has no data');
                return Center(child: Text('No messages'));
              } else {
                final messages = snapshot.data!;
                print('Messages loaded: ${messages.length}');
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Message message = messages[index];
                    print('Message: ${message.toJson()}');
                    return _buildMessageTile(message);
                  },
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  String messageText = _messageController.text.trim();
                  if (messageText.isNotEmpty) {
                    _sendMessage(messageText);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageTile(Message message) {
    return ListTile(
      title: Text(message.content),
      subtitle: Text(
        '${message.senderId} • ${DateFormat.yMMMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(message.sendAt))}',
        style: TextStyle(color: Colors.grey[600]),
      ),
      isThreeLine: true,
      leading: CircleAvatar(
        child: Text(message.senderId.substring(0, 2).toUpperCase()),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUI() {
    return Center(
      child: Text(errorMessage ?? 'Unknown error'),
    );
  }
}
