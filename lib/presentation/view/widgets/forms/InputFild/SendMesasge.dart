import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
    final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    String message = _controller.text;
    // Implement your send message functionality here
    print('Sending message: $message');
    _controller.clear(); // Clear the input field after sending the message
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: TextField(
          controller: _controller,
          onSubmitted: (value) {
            // Optionally handle submission (e.g., when the user presses the enter key)
            _sendMessage();
          },
          decoration: InputDecoration(
            hintText: 'Saisissez votre message',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ),
        ),
      );
    
  }
}