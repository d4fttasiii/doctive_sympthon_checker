import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/main.dart';
import 'package:doctive_sympthon_checker/models/register_user_dto.dart';
import 'package:doctive_sympthon_checker/pages/dashboard_screen.dart';
import 'package:doctive_sympthon_checker/services/crypto_service.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/mnemonic_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  static const route = '/onboarding';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  final _crypto = resolver<CryptoService>();
  final _user = resolver<UserService>();

  AnimationController? _animationController;
  Animation<double>? _animation;

  final PageController _pageController = PageController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final Map<int, TextEditingController> _mnemonicVerificationControllers = {
    0: TextEditingController(),
    1: TextEditingController(),
    2: TextEditingController(),
  };
  late String _mnemonic;
  late List<String> _mnemonicWords = [];
  final _formKey = GlobalKey<FormState>();
  Future<void>? _submitFuture;

  @override
  void initState() {
    super.initState();
    _mnemonic = _crypto.generateMnemonic();
    _mnemonicWords = _mnemonic.split(' ');
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _animationController!.forward();
  }

  void generateMnemonic() {
    setState(() {
      _mnemonic = _crypto.generateMnemonic();
      _mnemonicWords = _mnemonic.split(' ');
    });
  }

  void _onSubmitPressed() {
    if (_mnemonicVerificationControllers[0]?.text == _mnemonicWords[0] &&
        _mnemonicVerificationControllers[1]?.text == _mnemonicWords[4] &&
        _mnemonicVerificationControllers[2]?.text == _mnemonicWords[8]) {
      setState(() {
        _submitFuture = submitRegistrationForm();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid secret words! Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> submitRegistrationForm() async {
    await _user.register(
      _mnemonic,
      RegisterUserDto(
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text,
        message: '',
        signature: '',
        walletAddress: '',
      ),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Onboarding"), // Title can be updated according to the page.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_pageController.page! > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF488051), Color(0xFFABC5A8)],
          ),
        ),
        child: PageView(
          controller: _pageController,
          children: [
            _buildPersonalInfoPage(),
            _buildMnemonicPage(),
            _buildMnemonicVerificationPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Firstname',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Lastname',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!regex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: const Color(0xFF488051),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ));
  }

  Widget _buildMnemonicPage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text('Please write down your secret phrase:',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Mnemonic(
              mnemonicWords: _mnemonicWords,
              width: double.infinity,
              height: 500.0,
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: generateMnemonic,
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text('Generate'),
                  ),
                ),
                const SizedBox(width: 10), // For spacing between the buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color(0xFF488051),
                    ),
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildMnemonicVerificationPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Enter the 1st, 5th and 9th word from the secret phrase:',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _mnemonicVerificationControllers[0],
                  decoration: const InputDecoration(
                    labelText: '1st word',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                )),
            const SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _mnemonicVerificationControllers[1],
                  decoration: const InputDecoration(
                    labelText: '5th word',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                )),
            const SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _mnemonicVerificationControllers[2],
                  decoration: const InputDecoration(
                    labelText: '9th word',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                )),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return Text('Submit');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
