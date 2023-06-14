import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/models/user_personal_information.dart';
import 'package:doctive_sympthon_checker/pages/profile_screen.dart';
import 'package:doctive_sympthon_checker/widgets/bordered_date_picker.dart';
import 'package:doctive_sympthon_checker/widgets/bordered_dropdown.dart';
import 'package:doctive_sympthon_checker/widgets/bordered_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/user_service.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  static const route = '/doctive/profile/edit-personal-information';

  @override
  EditPersonalInformationScreenState createState() =>
      EditPersonalInformationScreenState();
}

class EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  final _userService = resolver<UserService>();
  Future<UserDto>? _profileFuture;
  Future<void>? _submitFuture;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _streetNrController = TextEditingController();

  final _genders = ['NotSet', 'Female', 'Male'];

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _countryCodeController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _streetNrController.dispose();
    super.dispose();
  }

  Future<UserDto> _fetchProfile() async {
    // Update the following with your own logic
    try {
      final profile = await _userService.getProfile();
      if (profile.personalInfo != null) {
        _dateOfBirthController.text = profile.personalInfo!.dateOfBirth.toIso8601String();
        _genderController.text = profile.personalInfo!.gender;
        _countryCodeController.text = profile.personalInfo!.countryCode;
        _zipCodeController.text = profile.personalInfo!.zipCode;
        _cityController.text = profile.personalInfo!.city;
        _streetController.text = profile.personalInfo!.street;
        _streetNrController.text = profile.personalInfo!.streetNr;
      }
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
    }
  }

  Future<void> _submitForm() async {
    await _userService.updateUserPersonalInformation(UserPersonalInformation(
      dateOfBirth: DateFormat('yyyy-MM-dd').parse(_dateOfBirthController.text),
      gender: _genderController.text,
      countryCode: _countryCodeController.text,
      zipCode: _zipCodeController.text,
      city: _cityController.text,
      street: _streetController.text,
      streetNr: _streetNrController.text,
    ));
    
    Navigator.of(context).pushReplacementNamed(ProfileScreen.route, arguments: {
      'message': 'Personal information successfully updated!',
      'showMessage': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Personal Information'),
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
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        BorderedDatePicker(
                          label: 'Date of Birth',
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            _dateOfBirthController.text = date
                                    .toIso8601String()
                                    .split('T')[
                                0]; // Converting the date to yyyy-mm-dd format
                          },
                        ),
                        const SizedBox(height: 30),
                        BorderedDropdownInput(
                          label: 'Gender',
                          value: _genderController.text,
                          items: [
                            ..._genders.map((v) => DropdownMenuItem<String>(
                                  value: v,
                                  child: Text(v),
                                ))
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _genderController.text = newValue ?? '';
                            });
                          },
                        ),
                        // const SizedBox(height: 30),
                        // _buildField('Country', _countryCodeController),
                        const SizedBox(height: 30),
                        BorderedTextField(
                          label: 'Zip Code',
                          controller: _zipCodeController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zip code';
                            }
                            if (value.length > 5) {
                              return 'Please enter a valid zip code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        BorderedTextField(
                          label: 'City',
                          controller: _cityController,
                        ),
                        const SizedBox(height: 30),
                        BorderedTextField(
                          label: 'Street',
                          controller: _streetController,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        const SizedBox(height: 30),
                        BorderedTextField(
                          label: 'Street Nr.',
                          controller: _streetNrController,
                          keyboardType: TextInputType.number,
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
