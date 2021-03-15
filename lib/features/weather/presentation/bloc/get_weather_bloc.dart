import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_flutter/core/error/failures.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/features/weather/domain/usecases/get_weather.dart';
import 'package:dartz/dartz.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

const String ERROR_MESSAGE = 'Falha ao buscar clima!';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  GetWeatherBloc({@required this.getWeather}) : super(GetWeatherInitial());

  final GetWeather getWeather;

  @override
  Stream<GetWeatherState> mapEventToState(
    GetWeatherEvent event,
  ) async* {
    yield GetWeatherLoading();
    if (event is GetWeatherE) {
      final failureOrWeather =
          await getWeather(Params(cityName: event.cityName));
      yield* _eitherLoadedOrErrorState(failureOrWeather);
    }
  }

  Stream<GetWeatherState> _eitherLoadedOrErrorState(
    Either<Failure, Weather> failureOrWeather,
  ) async* {
    yield failureOrWeather.fold(
      (failure) => GetWeatherError(message: _mapFailureToMessage(failure)),
      (weather) => GetWeatherLoaded(weather: weather),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ERROR_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
