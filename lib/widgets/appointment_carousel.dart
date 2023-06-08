import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/appointment.dart';
import 'appointment_card_widget.dart';

class AppointmentCarousel extends StatefulWidget {
  final List<Appointment> appointments;
  final double width;

  AppointmentCarousel({required this.appointments, required this.width});

  @override
  _AppointmentCarouselState createState() => _AppointmentCarouselState();
}

class _AppointmentCarouselState extends State<AppointmentCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width, // Add this
          child: CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 200,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: [
              ...widget.appointments.map((appointment) => AppointmentCard(
                    date: appointment.date.toString(),
                    location: appointment.location,
                    name: appointment.name,
                  ))
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.appointments.map((appointment) {
              int index = widget.appointments.indexOf(appointment);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
