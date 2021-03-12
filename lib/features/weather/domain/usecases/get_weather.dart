import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:teste_flutter/core/usecases/usecase.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/features/weather/domain/repositories/weather_repository.dart';

class GetWeather implements UseCase<Weather, Params> {
  final WeatherRepository weatherRepository;
  GetWeather(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(Params params) async {
    return await weatherRepository.getWeather(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;

  Params({@required this.cityName});

  @override
  List<Object> get props => [cityName];
}
