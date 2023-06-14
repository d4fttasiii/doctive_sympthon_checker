import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/main.dart';
import 'package:doctive_sympthon_checker/pages/profile_screen.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const route = '/doctive/profile/email-verification';

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _userService = resolver<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  Future<void>? _verifyFuture;

  resendToken() async {
    await _userService.requestEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email verification token sent!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> verify() async {
    FocusScope.of(context).unfocus();
    if (_tokenController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Token must be 6 characters long.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await _userService.verifyEmail(_tokenController.text);
      Navigator.of(context).pushReplacementNamed(ProfileScreen.route, arguments: {
        'message': 'Email verification successful!',
        'showMessage': true,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Email Verification'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF488051), Color(0xFFABC5A8)],
            ),
          ),
          child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: 144, // Adjust as needed
                  width: 144, // Adjust as needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        77), // Half of the width and height for a perfect circle
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.email,
                      color: AppColors.primaryColor,
                      size: 77,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Verify your email address',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'Enter the code sent to you',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: _tokenController,
                                decoration: const InputDecoration(
                                  labelText: 'Enter verification token',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 6) {
                                    return 'Please enter a valid token';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Enter the code sent to you? ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        await resendToken();
                                      },
                                      child: const Text(
                                        'RESEND',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FutureBuilder(
                                future: _verifyFuture,
                                builder: (context, snapshot) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _verifyFuture = verify();
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: const Color(0xFF488051),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    child: snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? CircularProgressIndicator(
                                            color: Color(0xFF488051),
                                          )
                                        : const Text('Verify'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ))))
          ]),
        ));
  }
}
