import 'package:flutter/material.dart';

class InformationBlockWidget extends StatelessWidget {
  const InformationBlockWidget({
    Key? key,
    required String textToDisplay,
  })  : _textToDisplay = textToDisplay,
        super(key: key);

  final String _textToDisplay;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 290,
        height: 50,
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            _textToDisplay,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
