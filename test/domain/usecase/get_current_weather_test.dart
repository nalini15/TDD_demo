import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_demo/domain/entities/weather.dart';
import 'package:tdd_demo/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  MockWeatherRepo mockWeatherRepo;
  setUp(() {
    mockWeatherRepo = MockWeatherRepo();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepo);
  });

  const testWeatherDetail = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode:'02d',
      temperature:302.68,
      pressure:1009,
      humidity:70);

  const testCityName = "New York";

  test('Should get current weather detail from repository', () async {
    ///Arrange
    mockWeatherRepo = MockWeatherRepo();
        when(
            mockWeatherRepo.getCurrentWeather(testCityName)
        ).thenAnswer((_)async => const Right(testWeatherDetail));

        ///ACT
    getCurrentWeatherUseCase= GetCurrentWeatherUseCase(mockWeatherRepo);
    final result = await getCurrentWeatherUseCase.execute(testCityName);


    ///Assert
    expect(result, Right(testWeatherDetail));
  }
  );
}
