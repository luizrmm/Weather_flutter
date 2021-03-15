import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:teste_flutter/core/error/exceptions.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls the weather endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  final String baseUrl =
      "https://api.hgbrasil.com/weather?key=918cc734&city_name=";

  WeatherRemoteDataSourceImpl({@required this.client});

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await client.get(
      Uri.parse('$baseUrl$cityName'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
