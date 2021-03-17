import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/network.png',
          height: 110,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
