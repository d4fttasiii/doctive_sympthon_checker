import 'package:flutter/material.dart';

class Conversation {
  final String name;
  final String lastMessage;
  final DateTime date;

  Conversation(
      {required this.name, required this.lastMessage, required this.date});
}

class ConversationListScreen extends StatefulWidget {
  static const route = '/doctive/conversations';

  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<Conversation> conversations = [
    Conversation(
        name: 'Conversation 1', lastMessage: 'Hello', date: DateTime.now()),
    Conversation(
        name: 'Conversation 2',
        lastMessage: 'How are you?',
        date: DateTime.now().subtract(Duration(days: 1))),
    // Add more conversations here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to start a new conversation
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(conversations[index].name),
            subtitle: Text(conversations[index].lastMessage),
            trailing: Text(conversations[index].date.toString()),
          );
        },
      ),
    );
  }
}
