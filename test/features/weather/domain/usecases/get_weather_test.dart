import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_flutter/features/weather/domain/usecases/get_weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  final tCityName = "Muzambinho";
  final tWeather = Weather(
      temperature: 18,
      time: "0:00",
      description: "description teste",
      currently: "currently",
      conditionSlug: "conditionSlug",
      cityName: "Muzambinho");

  group("usecase", () {
    late MockWeatherRepository mockWeatherRepository;
    late GetWeather usecase;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      usecase = GetWeather(mockWeatherRepository);
    });
    test('shoud get the wather from de repository', () async {
      // arrange
      when(() => mockWeatherRepository.getWeather(any()))
          .thenAnswer((invocation) async => Right(tWeather));
      //actual
      final result = await usecase(Params(cityName: tCityName));
      // assert
      expect(result, Right(tWeather));
      verify(() => mockWeatherRepository.getWeather(tCityName));
      verifyNoMoreInteractions(mockWeatherRepository);
    });
  });
}