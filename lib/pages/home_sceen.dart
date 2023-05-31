import 'package:doctive_sympthon_checker/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';

import 'restore_account_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF488051), Color(0xFF8aad8c), Color(0xFFABC5A8)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              flex: 3,
              child: Center(
                child: FlutterLogo(size: 150), // Replace with your logo
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Welcome to Doctive',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OnBoardingScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Color(0xFF488051),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('New Account'),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RestoreAccountPage()));
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('Restore Account'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
