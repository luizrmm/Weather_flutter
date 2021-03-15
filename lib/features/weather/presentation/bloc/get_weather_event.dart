part of 'get_weather_bloc.dart';

abstract class GetWeatherEvent extends Equatable {
  const GetWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherE extends GetWeatherEvent {
  final String cityName;
  GetWeatherE(this.cityName);

  @override
  List<Object> get props => [cityName];
}
