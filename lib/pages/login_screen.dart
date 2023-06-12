import 'package:doctive_sympthon_checker/pages/authentication_failed_screen.dart';
import 'package:doctive_sympthon_checker/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userService = resolver<UserService>();

  Future<bool> _authenticate() async {
    try {
      if (await _userService.authenticate()) {
        await _userService.signIn();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _retry() async {
    if (await _userService.authenticate()) {
      await _userService.signIn();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _authenticate(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF488051), Color(0xFFABC5A8)],
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text(
                          'Authenticating...',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.data!) {
            // Handle when the user did not authenticate
            // Could return back to HomeScreen or show error message
            return AuthenticationFailedScreen(
                onRetry: _authenticate); // if you want to return to home screen
          } else {
            // Authentication successful, navigate to HomeScreen
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            });
            return Container();
          }
        },
      ),
    );
  }
}
