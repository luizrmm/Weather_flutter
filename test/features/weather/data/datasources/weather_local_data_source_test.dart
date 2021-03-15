import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter/core/error/exceptions.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  WeatherLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastWeather', () {
    final tWatherModel =
        WeatherModel.fromJson(jsonDecode(fixture('weather.json')));
    test(
        'should return the last weather from the sharedPreferences when is a one',
        () async {
      // arrenge
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('weather.json'));
      // actual
      final result = await dataSource.getLastWeather();
      // assert
      verify(mockSharedPreferences.getString(CACHED_WEATHER));
      expect(result, equals(tWatherModel));
    });
    test('should throw a CacheException when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //actual
      final call = dataSource.getLastWeather;
      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheWeather', () {
    final tWeatherModel = WeatherModel(
        temperature: 20,
        time: "1:36",
        description: "Tempo nublado",
        currently: "noite",
        conditionSlug: "cloud",
        cityName: "Sao Paulo");
    test('should call Shared Preferences to cache data', () async {
      // arrange

      //actual
      dataSource.cacheWeather(tWeatherModel);
      //assert
      final expectedJsonString = jsonEncode(tWeatherModel.toJson());
      verify(
          mockSharedPreferences.setString(CACHED_WEATHER, expectedJsonString));
    });
  });
}
