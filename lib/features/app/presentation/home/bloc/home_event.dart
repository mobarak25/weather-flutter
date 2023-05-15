part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Counter extends HomeEvent {
  const Counter({required this.count});
  final int count;
}

class GetWeather extends HomeEvent {}

class GetDate extends HomeEvent {}
