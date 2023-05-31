import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/user_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserService _userService = resolver<UserService>();
  Future<UserDto>? _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  Future<UserDto> _fetchProfile() async {
    try {
      return await _userService.getProfile();
    } catch (e) {
      // Handle exceptions as necessary
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<UserDto>(
        future: _profileFuture,
        builder: (BuildContext context, AsyncSnapshot<UserDto> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Firstname: ${snapshot.data!.firstname}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Lastname: ${snapshot.data!.lastname}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email: ${snapshot.data!.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email Verified: ${snapshot.data!.isEmailVerified ? "Yes" : "No"}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: snapshot.data!.isEmailVerified
                        ? null
                        : () {
                            // TODO: Implement email verification logic here
                          },
                    child: Text('Verify Email'),
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