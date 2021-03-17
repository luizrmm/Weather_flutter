import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
