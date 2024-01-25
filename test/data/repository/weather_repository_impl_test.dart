import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart'as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_demo/data/data_source/remote_data_source.dart';
import 'package:tdd_demo/data/model/weather_model.dart';
import 'package:tdd_demo/data/repository/weather_repo_impl.dart';
import 'package:tdd_demo/domain/entities/weather.dart';
import 'package:tdd_demo/domain/repositories/weather_repo.dart';
import 'package:tdd_demo/errors/errors.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([

  WeatherRepo,
  WeatherRemoteDataSource
],customMocks: [MockSpec<http.Client>(as: #MockHttpClient)]
)

void main(){
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepoImpl weatherRepoImpl;

  setUp((){
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepoImpl = WeatherRepoImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  const testCityName = 'New York';
  group('get current weather', () {
    test('should return current weather when call to data source is successful', () async{
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenAnswer((_)async => testWeatherModel);
      //act
      final result = await weatherRepoImpl.getCurrentWeather(testCityName);
      //result
      expect(result, equals(Right(testWeatherEntity)));
    });

    ///server failure
    test('should return server failure', () async{
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenThrow(ServerException());
      //act
      final result = await weatherRepoImpl.getCurrentWeather(testCityName);
      //result
      expect(result, equals(const Left(ServerFailure('error has occured'))));
    });

    ///connection failure
    test(
      'should return connection failure when the device has no internet',
          () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await weatherRepoImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );

  });
}