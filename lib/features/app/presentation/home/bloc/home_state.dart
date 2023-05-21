part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.weather = const Weather(),
      this.date = '',
      this.location = 'auto:ip',
      this.isloading = false,
      this.weatherType = WeatherType.sunny,
      this.forecastTime = ''});

  final Weather weather;
  final String date, location;
  final bool isloading;
  final WeatherType weatherType;
  final String forecastTime;

  HomeState copyWith(
      {String? date,
      Weather? weather,
      String? location,
      bool? isloading,
      WeatherType? weatherType,
      String? forecastTime}) {
    return HomeState(
        weather: weather ?? this.weather,
        date: date ?? this.date,
        location: location ?? this.location,
        isloading: isloading ?? this.isloading,
        weatherType: weatherType ?? this.weatherType,
        forecastTime: forecastTime ?? this.forecastTime);
  }

  @override
  List<Object> get props =>
      [weather, date, location, isloading, weatherType, forecastTime];
}

class HomeInitial extends HomeState {}
