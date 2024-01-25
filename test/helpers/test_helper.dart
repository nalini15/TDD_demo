import 'package:mockito/annotations.dart';
import 'package:tdd_demo/data/data_source/remote_data_source.dart';
import 'package:tdd_demo/domain/repositories/weather_repo.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_demo/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepo,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main(){}