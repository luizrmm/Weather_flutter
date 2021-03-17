import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_flutter/features/weather/presentation/bloc/get_weather_bloc.dart';

class FormSearch extends StatefulWidget {
  @override
  _FormSearchState createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final cityNameController = TextEditingController();
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: TextField(
        controller: cityNameController,
        onChanged: (value) {
          cityName = value;
        },
        decoration: InputDecoration(
          hintText: 'Location',
          contentPadding: EdgeInsets.only(left: 8, right: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
              icon: Icon(Icons.search), onPressed: dispatchGetWather),
        ),
      ),
    );
  }

  void dispatchGetWather() {
    cityNameController.clear();
    BlocProvider.of<GetWeatherBloc>(context).add(
      GetWeatherE(cityName),
    );
  }
}
