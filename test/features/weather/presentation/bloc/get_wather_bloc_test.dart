import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:teste_flutter/features/weather/data/models/weather_enum.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/features/weather/domain/usecases/get_weather.dart';
import 'package:teste_flutter/features/weather/presentation/bloc/get_weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetWeather extends Mock implements GetWeather {}

void main() {
  GetWeatherBloc bloc;
  MockGetWeather mockGetWeather;

  setUp(() {
    mockGetWeather = MockGetWeather();
    bloc = GetWeatherBloc(getWeather: mockGetWeather);
  });
  test('initialState should be AuthenticationInitial', () {
    //arrange
    final bloc = GetWeatherBloc(getWeather: mockGetWeather);
    // assert
    expect(bloc.state, equals(GetWeatherInitial()));
    bloc.close();
  });

  group('get weather bloc test', () {
    final String tCityName = 'Sao Paulo';

    final tWeather = Weather(
        temperature: 20,
        time: "1:36",
        description: "Tempo nublado",
        currently: "noite",
        conditionSlug: WeatherCondition.cloudy,
        cityName: "Sao Paulo");

    blocTest('should emit [loading, loaded] from get weather use case',
        build: () {
          when(mockGetWeather(any)).thenAnswer((_) async => Right(tWeather));
          return GetWeatherBloc(getWeather: mockGetWeather);
        },
        act: (bloc) => bloc.add(GetWeatherE(tCityName)),
        expect: () => [
              GetWeatherLoading(),
              GetWeatherLoaded(weather: tWeather),
            ]);

    blocTest('should emit [loading, error] from get weather use case',
        build: () {
          when(mockGetWeather(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return GetWeatherBloc(getWeather: mockGetWeather);
        },
        act: (bloc) => bloc.add(GetWeatherE(tCityName)),
        expect: () => [
              GetWeatherLoading(),
              GetWeatherError(message: ERROR_MESSAGE),
            ]);
  });
}
