import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_flutter/features/weather/presentation/bloc/get_weather_bloc.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<GetWeatherBloc, GetWeatherState>(
              builder: (context, state) {
            if (state is GetWeatherLoaded) {
              return Center(child: Text(state.weather.cityName ?? "we"));
            }
            return Container();
          }),
          TextButton(
              onPressed: () {
                BlocProvider.of<GetWeatherBloc>(context)
                    .add(GetWeatherE('Muzambinho'));
              },
              child: Text('sd'))
        ],
      ),
    );
  }
}
