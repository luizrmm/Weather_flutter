import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter/core/error/exceptions.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Gets the cached [WeatherModel] which was gotten the last time.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getLastWeather();

  Future<void> cacheWeather(WeatherModel weatherModel);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<WeatherModel> getLastWeather() async {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    return sharedPreferences.setString(
      CACHED_WEATHER,
      jsonEncode(weatherToCache.toJson()),
    );
  }
}
