import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Mnemonic extends StatefulWidget {
  const Mnemonic({
    Key? key,
    this.width,
    this.height,
    required this.mnemonicWords,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<String>? mnemonicWords;

  @override
  _MnemonicState createState() => _MnemonicState();
}

class _MnemonicState extends State<Mnemonic> {
  @override
  Widget build(BuildContext context) {
    if (widget.mnemonicWords == null || widget.mnemonicWords!.isEmpty) {
      return Container();
    }

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? (MediaQuery.of(context).size.height * 0.8),
      child: GridView.builder(
        itemCount: widget.mnemonicWords!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Center(
                  child: Text(
                    widget.mnemonicWords![index],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tertiaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
