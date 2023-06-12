import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        date: DateTime.now().subtract(const Duration(days: 1))),
    // Add more conversations here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conversations',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
            title: Text(
              conversations[index].name,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              conversations[index].lastMessage,
              style: const TextStyle(
                  color: AppColors.tertiaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              DateFormat('dd.MM.yyyy HH:mm').format(conversations[index].date),
              style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            leading: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(28.0)),
              child: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.white,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}
