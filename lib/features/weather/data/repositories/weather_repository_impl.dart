import 'package:teste_flutter/core/platform/network_info.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:teste_flutter/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Weather>> getWeather(String cityName) {
    throw UnimplementedError();
  }
}
