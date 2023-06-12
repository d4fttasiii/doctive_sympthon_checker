import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/pages/edit_profile_screen.dart';
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
  Future<UserDto>? _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  Future<UserDto> _fetchProfile() async {
    try {
      final profile = await _userService.getProfile();
      return profile;
    } catch (e) {
      // Handle exceptions as necessary
      throw Exception('Failed to load profile');
    }
  }

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
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topRight,
              //     end: Alignment.bottomLeft,
              //     colors: [Color(0xFF488051), Color(0xFFABC5A8)],
              //   ),
              // ),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(children: [
                          SizedBox(height: 30.0),
                          Center(
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
                          SizedBox(height: 30.0),
                          Text(
                            '${snapshot.data!.firstname} ${snapshot.data!.lastname}',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ]),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xFF488051), Color(0xFFABC5A8)],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          subtitle: Text('Change your name or update your email address',
                              style: TextStyle(
                                  color: AppColors.tertiaryColor,
                                  fontSize: 12)),
                          leading: Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, EditProfileScreen.route);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Personal Details',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          subtitle: Text('Update your personal information',
                              style: TextStyle(
                                  color: AppColors.tertiaryColor,
                                  fontSize: 12)),
                          leading: Icon(
                            Icons.perm_identity_rounded,
                            color: AppColors.primaryColor,
                          ),
                          // onTap: () {
                          //   Navigator.pushNamed(context, ShowRecoveryPhrase.route);
                          // },
                        ),
                        ListTile(
                          title: Text(
                            'Email Verification',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          subtitle: Text('Verify your email address',
                              style: TextStyle(
                                  color: AppColors.tertiaryColor,
                                  fontSize: 12)),
                          leading: Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, EmailVerificationScreen.route);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
