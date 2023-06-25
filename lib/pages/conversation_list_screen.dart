import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/main.dart';
import 'package:doctive_sympthon_checker/models/user_conversation_dto.dart';
import 'package:doctive_sympthon_checker/pages/start_conversation_screen.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
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
  final _userService = resolver<UserService>();
  Future<List<UserConversationDto>>? _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _conversationsFuture = _fetchConversations();
  }

  Future<List<UserConversationDto>> _fetchConversations() async {
    try {
      final conversations = await _userService.getConversations();
      return conversations;
    } catch (e) {
      throw Exception('Failed to load conversations');
    }
  }

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
              Navigator.of(context).pushNamed(StartConversation.route);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserConversationDto>>(
        future: _conversationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].topic,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  // subtitle: Text(
                  //   snapshot.data![index].lastMessage,
                  //   style: const TextStyle(
                  //       color: AppColors.tertiaryColor,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  trailing: Text(
                    DateFormat('dd.MM.yyyy HH:mm')
                        .format(snapshot.data![index].createdAt),
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
            );
          }
        },
      ),
    );
  }
}
