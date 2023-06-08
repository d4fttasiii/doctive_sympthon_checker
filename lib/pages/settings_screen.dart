import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/pages/show_recovery_phrase.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const route = '/doctive/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text(
              'Notifications',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
            subtitle: Text('Enable or disable notifications',
                style: TextStyle(color: AppColors.tertiaryColor, fontSize: 12)),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });

              // You can also store this value in a place where you can read it
              // when you receive a notification and decide whether to show it.
            },
          ),
          ListTile(
            title: Text(
              'Show Secret Phrase',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
            subtitle: Text(
                'Revisit your generated secret phrase for account recovery',
                style: TextStyle(color: AppColors.tertiaryColor, fontSize: 12)),
            leading: Icon(Icons.security, color: AppColors.primaryColor,),
            onTap: () {
              Navigator.pushNamed(context, ShowRecoveryPhrase.route);
            },
          )
        ],
      ),
    );
  }
}
