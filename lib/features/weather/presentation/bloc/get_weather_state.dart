part of 'get_weather_bloc.dart';

abstract class GetWeatherState extends Equatable {
  const GetWeatherState();

  @override
  List<Object> get props => [];
}

class GetWeatherInitial extends GetWeatherState {
  const GetWeatherInitial();
  @override
  List<Object> get props => [];
}

class GetWeatherLoading extends GetWeatherState {
  const GetWeatherLoading();
  @override
  List<Object> get props => [];
}

class GetWeatherLoaded extends GetWeatherState {
  final Weather weather;
  const GetWeatherLoaded({@required this.weather});
  @override
  List<Object> get props => [];
}

class GetWeatherError extends GetWeatherState {
  final String message;

  GetWeatherError({@required this.message});
  @override
  List<Object> get props => [message];
}
