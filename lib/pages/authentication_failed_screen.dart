import 'package:flutter/material.dart';

class AuthenticationFailedScreen extends StatefulWidget {
  final VoidCallback onRetry;

  AuthenticationFailedScreen({required this.onRetry});

  @override
  _AuthenticationFailedScreenState createState() =>
      _AuthenticationFailedScreenState();
}

class _AuthenticationFailedScreenState
    extends State<AuthenticationFailedScreen> {
  bool isLoading = false;

  void _onRetry() {
    setState(() {
      isLoading = true;
    });
    widget.onRetry();
    setState(() {
      isLoading = false;
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Authentication Failed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _onRetry,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Color(0xFF488051),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Retry'),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
