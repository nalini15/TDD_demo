import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tdd_demo/core/constants/constants.dart';
import 'package:tdd_demo/data/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_demo/domain/repositories/weather_repo.dart';
import 'package:tdd_demo/errors/errors.dart';

abstract class WeatherRemoteDataSource{
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource{
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async{
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
     throw ServerException();
    }
  }

}