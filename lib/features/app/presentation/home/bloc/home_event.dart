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

class CallLocationModal extends HomeEvent {}

class GetLocation extends HomeEvent {
  const GetLocation({required this.location});
  final String location;
}

class GetMyLocation extends HomeEvent {}

class AutoCallWeather extends HomeEvent {}

class ChangeWeather extends HomeEvent {}

class GetForcastTime extends HomeEvent {
  const GetForcastTime({required this.getTime});
  final int getTime;
}
