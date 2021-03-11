import 'package:dartz/dartz.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeather(String cityName);
}
