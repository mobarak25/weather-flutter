part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.count = 0,
    this.weather = const Weather(),
  });

  final int count;
  final Weather weather;

  HomeState copyWith({int? count, Weather? weather}) {
    return HomeState(
      count: count ?? this.count,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object> get props => [count, weather];
}

class HomeInitial extends HomeState {}
