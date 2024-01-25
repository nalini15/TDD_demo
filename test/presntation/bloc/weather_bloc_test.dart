import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_demo/domain/entities/weather.dart';
import 'package:tdd_demo/domain/repositories/weather_repo.dart';
import 'package:tdd_demo/presentation/bloc/weather_bloc.dart';
import 'package:tdd_demo/presentation/bloc/weather_event.dart';
import 'package:tdd_demo/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('initial state should be empty',
      () => {expect(weatherBloc.state, WeatherEmpty())});

  blocTest<WeatherBloc, WeatherState>(
      'should emit [weather loading, weather loaded]when data is gotten successfully',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(OnCityChanged(testCityName)),
      wait: Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), WeatherLoaded(testWeather)]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [weather loading, weather failure]when data is gotten successfully',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), WeatherLoadFailure('server failure')]);
}
