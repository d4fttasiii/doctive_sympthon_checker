import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  final bool isDisabled;

  MenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDisabled ? AppColors.tertiaryColor : AppColors.secondaryColor,
            width: 1.0, // adjust width as needed
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              size: 32,
              color: isDisabled ? AppColors.tertiaryColor : AppColors.primaryColor,
            ),
          ),
          TextButton(
            onPressed: () {
              if (isDisabled) {
                return;
              }
              onTap();
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18, // adjust size as needed
                color: isDisabled ? AppColors.tertiaryColor : AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
