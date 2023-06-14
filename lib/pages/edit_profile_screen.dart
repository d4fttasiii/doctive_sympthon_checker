import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/models/user_update_dto.dart';
import 'package:doctive_sympthon_checker/pages/profile_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = '/doctive/profile/edit';

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _userService = resolver<UserService>();
  Future<UserDto>? _profileFuture;
  Future<void>? _submitFuture;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
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

  void _onSubmitPressed() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitFuture = _submitForm();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid secret words! Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _submitForm() async {
    await _userService.updateProfile(UserUpdateDto(
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text));
    Navigator.of(context).pushReplacementNamed(ProfileScreen.route, arguments: {
      'message': 'Profile update successful!',
      'showMessage': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF488051), Color(0xFFABC5A8)],
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
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
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
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
                        ElevatedButton(
                          onPressed: _onSubmitPressed,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: AppColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: FutureBuilder(
                            future: _submitFuture,
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
                );
              }
            }));
  }
}
