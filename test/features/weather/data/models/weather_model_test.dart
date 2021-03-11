import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
      temperature: 20,
      time: "01:36",
      description: "Tempo nublado",
      currently: "noite",
      conditionSlug: "cloud",
      cityName: "Sao Paulo");

  test('should be a subclass of Weather Entity', () {
    //asset
    expect(tWeatherModel, isA<Weather>());
  });

  group("parser", () {
    test("should return as valid model when the city name exists", () {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('weather.json'));
      //actual
      final result = WeatherModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tWeatherModel));
    });

    test('should return a json when a valid model exists', () {
      //actual
      final result = tWeatherModel.toJson();
      //assert
      final expectedMap = {
        "temp": 20,
        "time": "01:36",
        "description": "Tempo nublado",
        "currently": "noite",
        "condition_slug": "cloud",
        "city_name": "Sao Paulo"
      };
      expect(result, expectedMap);
    });
  });
}
