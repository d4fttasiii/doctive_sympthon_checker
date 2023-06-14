import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BorderedDatePicker extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateSelected;

  const BorderedDatePicker({
    Key? key,
    required this.label,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _BorderedDatePickerState createState() => _BorderedDatePickerState();
}

class _BorderedDatePickerState extends State<BorderedDatePicker> {
  late DateTime selectedDate;
  late String displayDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    displayDate = DateFormat('yyyy-MM-dd').format(widget.initialDate);
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        displayDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          '${widget.label}: ${displayDate}',
          style: const TextStyle(color: Colors.black),
        ),
        trailing: const Icon(Icons.calendar_today),
        onTap: _selectDate,
      ),
    );
  }
}
