import 'package:flutter/material.dart';
import 'dart:async';

import 'home_sceen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _animationController!.forward();

    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushNamed(context, HomeScreen.route));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF488051), Color(0xFFABC5A8)],
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: FadeTransition(
                opacity: _animation!,
                child: Image.asset(
                  'assets/doctive_full_logo.png', // Replace with the path to your image
                  height: 200, // You can adjust size as needed
                  // width: double.infinity, // You can adjust size as needed
                ),
              ),
            )),
      ),
    );
  }
}
