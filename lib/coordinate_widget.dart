import 'package:flutter/material.dart';

class CoordinateWidget extends StatelessWidget {
  const CoordinateWidget({
    Key? key,
    required String textToDisplay,
  })  : _textToDisplay = textToDisplay,
        super(key: key);

  final String _textToDisplay;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 250,
        height: 50,
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            _textToDisplay,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
