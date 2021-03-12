import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_flutter/core/error/exceptions.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:teste_flutter/core/network/network_info.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:teste_flutter/features/weather/data/models/weather_model.dart';
import 'package:teste_flutter/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';

class MockRemoteDataSouce extends Mock implements WeatherRemoteDataSource {}

class MockLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  WeatherRepositoryImpl repository;
  MockRemoteDataSouce mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSouce();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("getWather", () {
    final tCityName = 'Sao Paulo';

    final tWeatherModel = WeatherModel(
        temperature: 20,
        time: "1:36",
        description: "Tempo nublado",
        currently: "noite",
        conditionSlug: "cloud",
        cityName: "Sao Paulo");

    final Weather tWeather = tWeatherModel;
    test('should check if device is online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getWeather(tCityName);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should retun the data when the call to remote data source is successful",
          () async {
        // assert
        when(mockRemoteDataSource.getWeather(any))
            .thenAnswer((_) async => tWeatherModel);
        // act
        final result = await repository.getWeather(tCityName);
        // assert
        verify(mockRemoteDataSource.getWeather(tCityName));
        expect(result, equals(Right(tWeather)));
      });

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getWeather(tCityName))
              .thenAnswer((_) async => tWeatherModel);
          // act
          await repository.getWeather(tCityName);
          // assert
          verify(mockRemoteDataSource.getWeather(tCityName));
          verify(mockLocalDataSource.cacheWeather(tWeatherModel));
        },
      );

      test(
          "should return a server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getWeather(any)).thenThrow(ServerException());
        // actual
        final result = await repository.getWeather(tCityName);
        // assert
        verify(mockRemoteDataSource.getWeather(tCityName));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should get the lastest when local data cached is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastWeather())
            .thenAnswer((_) async => tWeatherModel);
        // actual
        final result = await repository.getWeather(tCityName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastWeather());
        expect(result, equals(Right(tWeather)));
      });

      test(
          'should return a cache failure when local data cached is not present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastWeather()).thenThrow(CacheException());
        // actual
        final result = await repository.getWeather(tCityName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastWeather());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
