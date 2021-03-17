import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter/core/network/network_info.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:teste_flutter/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:teste_flutter/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:teste_flutter/features/weather/domain/repositories/weather_repository.dart';
import 'package:teste_flutter/features/weather/domain/usecases/get_weather.dart';
import 'package:teste_flutter/features/weather/presentation/bloc/get_weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory<GetWeatherBloc>(
    () => GetWeatherBloc(getWeather: sl<GetWeather>()),
  );

  sl.registerLazySingleton<GetWeather>(
    () => GetWeather(sl<WeatherRepository>()),
  );

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl<WeatherRemoteDataSource>(),
      localDataSource: sl<WeatherLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () =>
        WeatherLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
}
