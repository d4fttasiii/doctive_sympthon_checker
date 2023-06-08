import 'package:flutter/material.dart';

class ConversationActivity {
  final String message;
  final bool isFromUser;

  ConversationActivity({required this.message, required this.isFromUser});
}

class ConversationScreen extends StatefulWidget {
  static const route = '/doctive/conversation';

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<ConversationActivity> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    _addMessage(text: text, isFromUser: true);

    // Respond to the message.
    _botResponse(text);
  }

  void _botResponse(String text) {
    // You would typically call your chat bot here.
    // This is just an echo bot that repeats what it received.
    _addMessage(text: text, isFromUser: false);
  }

  void _addMessage({required String text, required bool isFromUser}) {
    setState(() {
      _messages.add(ConversationActivity(message: text, isFromUser: isFromUser));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with Bot')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true, // To make the ListView start from the bottom.
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final chatMessage = _messages[index];
                final alignment =
                    chatMessage.isFromUser ? Alignment.topRight : Alignment.topLeft;
                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: chatMessage.isFromUser ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(chatMessage.message),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _messageController,
              onSubmitted: _sendMessage,
              decoration:
                  InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _sendMessage(_messageController.text);
                _messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
