import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/pages/email_verification_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/doctive/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userService = resolver<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Future<UserDto>? _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<UserDto> _fetchProfile() async {
    try {
      final profile = await _userService.getProfile();
      _firstNameController.text = profile.firstname;
      _lastNameController.text = profile.lastname;
      _emailController.text = profile.email;
      return profile;
    } catch (e) {
      // Handle exceptions as necessary
      throw Exception('Failed to load profile');
    }
  }

  _updateProfile() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<UserDto>(
        future: _profileFuture,
        builder: (BuildContext context, AsyncSnapshot<UserDto> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
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
                          Icons.person,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: _firstNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Firstname',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your firstname';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: _lastNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Lastname',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your lastname';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      validator: (value) {
                                        RegExp regex =
                                            RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else if (!regex.hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    !snapshot.data!.isEmailVerified ? "Your email address has not been verified yet!" : "Email Verified",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: snapshot.data!.isEmailVerified
                                        ? null
                                        : () {
                                            Navigator.pushNamed(context,
                                                EmailVerificationScreen.route);
                                          },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: const Color(0xFF488051),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    child: const Text('Verify Email'),
                                  ),
                                ],
                              ),
                            ))))
              ]),
            );
          }
        },
      ),
    );
  }
}
