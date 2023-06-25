import 'package:doctive_sympthon_checker/pages/conversation_screen.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/widgets/bordered_text_field.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class StartConversation extends StatefulWidget {
  static const route = '/doctive/conversation/new';

  StartConversation({Key? key}) : super(key: key);

  @override
  _StartConversationState createState() => _StartConversationState();
}

class _StartConversationState extends State<StartConversation> {
  final _user = resolver<UserService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _topicController = TextEditingController();
  late bool _canStartConversation;
  Future<void>? _startConversationFuture;

  Future<bool> canStartConversation() async {
    return await _user.canStartConversation();
  }

  Future<void> startConversation() async {
    final id = await _user.startConversation(_topicController.text);
    Navigator.of(context)
        .pushReplacementNamed(ConversationScreen.route, arguments: {
      'id': id,
    });
  }

  void _onSubmitPressed() {
    if (_canStartConversation) {
      setState(() {
        _startConversationFuture = startConversation();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to start a new conversation at the moment.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    canStartConversation().then((value) => _canStartConversation = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Conversation'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primaryColor, AppColors.tertiaryColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Center(
                    child: Container(
                      height: 144, // Adjust as needed
                      width: 144, // Adjust as needed
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            77), // Half of the width and height for a perfect circle
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/doctive_robot_doctor.png',
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Doctive Health Bot',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'What would you like to talk about?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        BorderedTextField(
                          label: 'Topic',
                          controller: _topicController,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ElevatedButton(
                          onPressed: _onSubmitPressed,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: AppColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: FutureBuilder(
                            future: _startConversationFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                return const Text('Submit');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
