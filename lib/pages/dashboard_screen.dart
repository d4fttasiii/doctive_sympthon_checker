import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/models/appointment.dart';
import 'package:doctive_sympthon_checker/pages/conversation_list_screen.dart';
import 'package:doctive_sympthon_checker/pages/profile_screen.dart';
import 'package:doctive_sympthon_checker/pages/settings_screen.dart';
import 'package:doctive_sympthon_checker/widgets/appointment_carousel.dart';
import 'package:doctive_sympthon_checker/widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/doctive_logo.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
                Container(
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Doctive',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    child: const Text(
                      'Upcoming appointments',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      AppointmentCarousel(
                        appointments: [
                          Appointment(
                              name: 'MRI',
                              date: DateTime(2023, 9, 10),
                              location: 'Berlin'),
                          Appointment(
                              name: 'MRI',
                              date: DateTime(2023, 9, 13),
                              location: 'Berlin'),
                        ],
                        width: MediaQuery.of(context).size.width * 0.90,
                      ),
                      // AppointmentCard(
                      //     name: 'Allergy Testing',
                      //     date: '10.02.2023',
                      //     location: 'Berlin'),
                    ],
                    mainAxisSize: MainAxisSize.max,
                  ),
                  const SizedBox(height: 30),
                  MenuItem(
                      icon: Icons.person_outline,
                      text: 'Profile',
                      onTap: () =>
                          Navigator.pushNamed(context, ProfileScreen.route)),
                  const SizedBox(height: 10),
                  MenuItem(
                    icon: Icons.monitor_heart,
                    text: 'Sympthon Analysis',
                    onTap: () => Navigator.pushNamed(context, ConversationListScreen.route),
                  ),
                  const SizedBox(height: 10),
                  MenuItem(
                    icon: Icons.medical_information,
                    text: 'Medical Records',
                    onTap: () => Navigator.pushNamed(context, ''),
                    isDisabled: true,
                  ),
                  const SizedBox(height: 10),
                  MenuItem(
                    icon: Icons.calendar_month,
                    text: 'Appointment Management',
                    onTap: () => Navigator.pushNamed(context, ''),
                    isDisabled: true,
                  ),
                  const SizedBox(height: 10),
                  MenuItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () => Navigator.pushNamed(context, SettingsScreen.route),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
