import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_flutter/features/weather/presentation/bloc/get_weather_bloc.dart';
import 'package:teste_flutter/features/weather/presentation/widgets/form.dart';
import 'package:teste_flutter/features/weather/presentation/widgets/weather_info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<GetWeatherBloc>(context).add(GetWeatherE('Muzambinho'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<GetWeatherBloc, GetWeatherState>(
                  builder: (context, state) {
                if (state is GetWeatherError) {
                  return Center(
                    child: Text('NetWork Error'),
                  );
                } else if (state is GetWeatherLoaded) {
                  return Column(
                    children: [
                      FormSearch(),
                      WeatherInfo(
                        weather: state.weather,
                      )
                    ],
                  );
                } else if (state is GetWeatherLoading) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()));
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
