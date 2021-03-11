import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:teste_flutter/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Either<Failure, Weather>> getWeather(String cityName) {
    throw UnimplementedError();
  }
}
