import 'package:dartz/dartz.dart';
import 'package:tdd_demo/domain/core/error/failure.dart';
import 'package:tdd_demo/domain/entities/weather.dart';

abstract class WeatherRepo{
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}

class ServerFailure extends Failure{
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure{
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure{
  const DatabaseFailure(super.message);
}