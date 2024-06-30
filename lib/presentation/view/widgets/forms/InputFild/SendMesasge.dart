import 'package:flutter/material.dart';
import 'package:takwira/presentation/managers/ChatManager.dart';

class SendMessage extends StatefulWidget {
  final String chatId;
  const SendMessage({super.key, required this.chatId});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
    final TextEditingController _controller = TextEditingController();
  final ChatManager _chatManager = ChatManager();

     Future<void> _sendMessage(String messageText) async {
    try {
      await _chatManager.sendMessage(widget.chatId, messageText);
      _controller.clear();
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
    return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: TextField(
          controller: _controller,
          onSubmitted: (value) {
            // Optionally handle submission (e.g., when the user presses the enter key)
            _sendMessage( value);
          },
          decoration: InputDecoration(
            hintText: 'Saisissez votre message',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
 _sendMessage(_controller.text);
              }
            ),
          ),
        ),
      );
    
  }
}