import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable{
  WeatherEvent();
  @override

  List<Object?> get props => [];

}

class OnCityChanged extends WeatherEvent{
  final String cityName;
  OnCityChanged(this.cityName);
  @override

  List<Object?> get props => [cityName];
}