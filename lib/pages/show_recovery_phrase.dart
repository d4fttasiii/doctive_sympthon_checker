import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/mnemonic_widget.dart';

class ShowRecoveryPhrase extends StatefulWidget {
  static const route = 'doctive/settings/mnemonic';

  @override
  _ShowRecoveryPhraseState createState() => _ShowRecoveryPhraseState();
}

class _ShowRecoveryPhraseState extends State<ShowRecoveryPhrase> {
  final _userService = resolver<UserService>();

  Future<List<String>> _getMnemonic() async {
    if (await _userService.authenticate()) {
      return (await _userService.getMnemonic()).split(' ');
    }

    throw Exception('Unable to access your secret phrase');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Phrase'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF488051), Color(0xFFABC5A8)],
          ),
        ),
        child: FutureBuilder<List<String>>(
          future: _getMnemonic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              // handle error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  Mnemonic(
                    mnemonicWords: snapshot.data!,
                    width: double.infinity,
                    height: 500.0,
                  ),
                  const SizedBox(height: 30),
                  const Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Your secret phrase is crucial for your account's security. Never share it with anyone. Disclosure can lead to unauthorized access to your account.",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.errorColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
