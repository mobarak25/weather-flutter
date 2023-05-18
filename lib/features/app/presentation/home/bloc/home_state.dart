part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.weather = const Weather(),
    this.date = '',
    this.location = 'auto:ip',
    this.isloading = false,
  });

  final Weather weather;
  final String date, location;
  final bool isloading;

  HomeState copyWith(
      {String? date, Weather? weather, String? location, bool? isloading}) {
    return HomeState(
      weather: weather ?? this.weather,
      date: date ?? this.date,
      location: location ?? this.location,
      isloading: isloading ?? this.isloading,
    );
  }

  @override
  List<Object> get props => [weather, date, location, isloading];
}

class HomeInitial extends HomeState {}
