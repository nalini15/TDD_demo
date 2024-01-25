import 'package:equatable/equatable.dart';
import 'package:tdd_demo/domain/entities/weather.dart';

class WeatherState extends Equatable {
  WeatherState();

  @override
  List<Object?> get props => [];
}

//initial state
class WeatherEmpty extends WeatherState {}

//wait for api state
class WeatherLoading extends WeatherState {}

//display data to user
class WeatherLoaded extends WeatherState {
  final WeatherEntity weatherEntityResult;

  WeatherLoaded(this.weatherEntityResult);

  @override
  List<Object?> get props => [weatherEntityResult];
}

// show user an error message
class WeatherLoadFailure extends WeatherState {
  final String message;

  WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
