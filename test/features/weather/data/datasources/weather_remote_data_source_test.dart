import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:teste_flutter/core/error/exceptions.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  WeatherRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get((any), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('weather.json'), 200));
  }

  void setUpMockHttpClientFailure40X() {
    when(mockHttpClient.get((any), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something wrong', 400));
  }

  group('getWeather Remote', () {
    final String baseUrl =
        "https://api.hgbrasil.com/weather?key=918cc734&city_name=";
    final String tCityName = 'Sao Paulo';

    final tWeatherModel =
        WeatherModel.fromJson(jsonDecode(fixture('weather.json')));
    test('should perform a GET request on a URL with the city name', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //actual
      dataSource.getWeather(tCityName);
      //assert
      verify(mockHttpClient.get(
        Uri.parse('$baseUrl$tCityName'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return a  Weather when the response code is 200 (successful)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // actual
      final result = await dataSource.getWeather(tCityName);
      // assert
      expect(result, equals(tWeatherModel));
    });
    test(
        'throw a Server Exception when the response code is 40X (unsuccessful)',
        () async {
      // arrange
      setUpMockHttpClientFailure40X();
      // actual
      final call = dataSource.getWeather;
      // assert
      expect(() => call(tCityName), throwsA(isA<ServerException>()));
    });
  });
}
