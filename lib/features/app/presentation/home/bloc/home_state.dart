part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.weather = const Weather(),
    this.date = '',
  });

  final Weather weather;
  final String date;

  HomeState copyWith({String? date, Weather? weather}) {
    return HomeState(
      weather: weather ?? this.weather,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [weather, date];
}

class HomeInitial extends HomeState {}
