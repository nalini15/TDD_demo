import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/data/model/weather_model.dart';
import 'package:tdd_demo/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: "New York",
      main: "clear",
      description: "clear sky",
      iconCode: "01n",
      temperature: 292.87,
      pressure: 1012,
      humidity: 70);
  test('Should be a subclass of weather entity', () async {
    //assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("Should return a valid model from json", () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });
  
  test('Should return a json map containing proper data', () async{
    //act
    final result = testWeatherModel.toJson();
    //assert
    final expectedJsonMap = {
      'Weather':[{
        'main': 'clear',
        'description':'clear sky',
        'icon':'01n'
    }],
      'main':{
        'temp': 292.87,
        'pressure': 1012,
        'humidity': 70,
      },
      'name':'New York'
    };
    expect(result, equals(expectedJsonMap));
  });
}
