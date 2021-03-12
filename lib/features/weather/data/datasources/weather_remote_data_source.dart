import 'package:teste_flutter/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  /// Calls the weather endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeather(String cityName);
}
