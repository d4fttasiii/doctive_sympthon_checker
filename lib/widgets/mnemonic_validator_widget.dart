import 'package:flutter/material.dart';
import 'dart:math';

class MnemonicCheck extends StatefulWidget {
  const MnemonicCheck({
    Key? key,
    this.width,
    this.height,
    required this.mnemonicWords,
    required this.onSubmit,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String> mnemonicWords;
  final Future<dynamic> Function() onSubmit;

  @override
  _MnemonicCheckState createState() => _MnemonicCheckState();
}

class _MnemonicCheckState extends State<MnemonicCheck> {
  late List<int> _randomIndices;
  late List<TextEditingController> _controllers;
  late List<bool> _isCorrect;

  @override
  void initState() {
    super.initState();

    _randomIndices = _generateRandomIndices();
    _controllers = List.generate(3, (_) => TextEditingController());
    _isCorrect = List.generate(3, (_) => false);

    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        _isCorrect[i] =
            _controllers[i].text == widget.mnemonicWords[_randomIndices[i]];
        setState(() {});
      });
    }
  }

  List<int> _generateRandomIndices() {
    var randomIndices = <int>[];
    var random = Random();
    while (randomIndices.length < 3) {
      var index = random.nextInt(12);
      if (!randomIndices.contains(index)) {
        randomIndices.add(index);
      }
    }
    return randomIndices;
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _randomIndices.length; i++) ...[
          TextFormField(
            controller: _controllers[i],
            decoration: InputDecoration(
              labelText: 'Word ${_randomIndices[i] + 1}',
              suffixIcon:
                  _isCorrect[i] ? Icon(Icons.check, color: Colors.green) : null,
            ),
          ),
        ],
        ElevatedButton(
          onPressed:
              _isCorrect.every((isValid) => isValid) ? widget.onSubmit : null,
          // style: ,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
