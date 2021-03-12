import 'package:teste_flutter/features/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Gets the cached [WeatherModel] which was gotten the last time.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getLastWeather();

  Future<void> cacheWeather(WeatherModel weatherModel);
}
