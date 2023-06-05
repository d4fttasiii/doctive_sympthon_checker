import 'package:flutter/material.dart';

import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/doctive';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false; // return false to prevent the route from being popped
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, ProfileScreen.route),
                  child: const Text('Profile Page'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/chat'),
                  child: const Text('Chat Page'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                  child: const Text('Settings Page'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Replace with actual logout method
                    print('User Logged Out');
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ));
  }
}
