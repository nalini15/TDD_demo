import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tdd_demo/data/data_source/remote_data_source.dart';
import 'package:tdd_demo/domain/core/error/failure.dart';
import 'package:tdd_demo/domain/entities/weather.dart';
import 'package:tdd_demo/domain/repositories/weather_repo.dart';
import 'package:tdd_demo/errors/errors.dart';

class WeatherRepoImpl extends WeatherRepo{
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepoImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async{
    try{
    final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
    return Right(result.toEntity());
    }on ServerException{
      return const Left(ServerFailure('error has occured'));
    }on SocketException{
      return const Left(ConnectionFailure('failed to connect'));
    }
  }
  
}