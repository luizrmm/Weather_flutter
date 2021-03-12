import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_flutter/core/platform/network_info.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:teste_flutter/features/weather/data/repositories/weather_repository_impl.dart';

class MockRemoteDataSouce extends Mock implements WeatherRemoteDataSource {}

class MockLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late WeatherRepositoryImpl mockRepository;
  late MockRemoteDataSouce mockRemoteDataSouce;
  late MockNetworkInfo mockNetworkInfo;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSouce = MockRemoteDataSouce();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockRepository = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteDataSouce,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
}
