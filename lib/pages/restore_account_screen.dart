import 'package:flutter/material.dart';
import 'package:doctive_sympthon_checker/widgets/bordered_text_field.dart';

class RestoreAccountScreen extends StatefulWidget {
  static const route = '/restore';

  @override
  _RestoreAccountScreenState createState() => _RestoreAccountScreenState();
}

class _RestoreAccountScreenState extends State<RestoreAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final List<TextEditingController> _controllers =
      List.generate(12, (index) => TextEditingController());
  int _currentPage = 0;

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      if (_formKey.currentState!.validate()) {
        String mnemonic = _controllers.map((c) => c.text).join(' ');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Invalid secret phrase was entered! Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restore account"),
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
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF488051),
              Color(0xFFABC5A8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, i) {
              _currentPage = i;
              return Column(
                children: [
                  for (var j = 0; j < 4; j++) ...[
                    const SizedBox(height: 30),
                    BorderedTextField(
                      label: '${i * 4 + j + 1}. word',
                      controller: _controllers[i * 4 + j],
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: nextPage,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color(0xFF488051),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(_currentPage < 2 ? 'Next' : 'Restore'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
