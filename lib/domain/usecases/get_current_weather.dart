import 'package:dartz/dartz.dart';
import 'package:tdd_demo/domain/core/error/failure.dart';
import 'package:tdd_demo/domain/entities/weather.dart';
import 'package:tdd_demo/domain/repositories/weather_repo.dart';

class GetCurrentWeatherUseCase{
final WeatherRepo weatherRepo;
const GetCurrentWeatherUseCase(this.weatherRepo);

Future<Either<Failure,WeatherEntity>>execute(String cityName){
  return weatherRepo.getCurrentWeather(cityName);
}
}