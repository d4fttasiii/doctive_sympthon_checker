import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String date;
  final String name;
  final String location;

  AppointmentCard(
      {required this.date, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primaryColor, AppColors.tertiaryColor],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ));
  }
}
