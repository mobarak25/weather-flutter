import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/navigator/iflutter_navigator.dart';
import 'package:weather/core/utils/utilities.dart';
import 'package:weather/features/app/domain/entities/weather.dart';
import 'package:weather/features/app/domain/repositories/api_repo.dart';
import 'package:weather/features/app/domain/repositories/local_storage_repo.dart';
import 'package:weather/features/app/presentation/home/widget/get_location_modal.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._apiRepo, this._localStorageRepo, this._iFlutterNavigator)
      : super(HomeInitial()) {
    on<GetWeather>(_getWeather);
    on<GetDate>(_getDate);
    on<CallLocationModal>(_callLocationModal);
    on<GetLocation>(_getLocation);
    on<GetMyLocation>(_getMyLocation);
    on<AutoCallWeather>(_autoCallWeather);

    add(GetWeather());
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _getWeather(GetWeather event, Emitter<HomeState> emit) async {
    final weatherStorage = await _localStorageRepo.readModal(
        key: 'weatherDB', value: const Weather());
    if (weatherStorage != null) {
      emit(state.copyWith(weather: weatherStorage));
    }
    emit(state.copyWith(isloading: true));
    final response = await _apiRepo.post(
        endpoint:
            "?key=05723c6f77864e33a1b60712231305&q=${state.location}&days=10",
        responseModal: const Weather());
    if (response != null) {
      emit(state.copyWith(weather: response));
      _localStorageRepo.writeModal(key: 'weatherDB', value: response);
      add(GetDate());
      add(AutoCallWeather());
    }
    emit(state.copyWith(isloading: false));
  }

  FutureOr<void> _getDate(GetDate event, Emitter<HomeState> emit) async {
    emit(state.copyWith(date: getDate(state.weather.current!.lastUpdated!)));
  }

  FutureOr<void> _callLocationModal(
      CallLocationModal event, Emitter<HomeState> emit) {
    getLocationModal(_iFlutterNavigator.context, pressSubmit: (String value) {
      add(GetLocation(location: value));
      _iFlutterNavigator.pop();
    });
  }

  FutureOr<void> _getLocation(GetLocation event, Emitter<HomeState> emit) {
    emit(state.copyWith(location: event.location));
    add(GetWeather());
  }

  FutureOr<void> _getMyLocation(GetMyLocation event, Emitter<HomeState> emit) {
    emit(state.copyWith(location: 'auto:ip'));
    add(GetWeather());
  }

  FutureOr<void> _autoCallWeather(
      AutoCallWeather event, Emitter<HomeState> emit) {
    //var counter = 3;
    Timer.periodic(const Duration(minutes: 2), (timer) {
      add(GetWeather());
      print(timer.tick);
      // counter--;
      // if (counter == 0) {
      //   print('Cancel timer');
      //   timer.cancel();
      // }
    });
  }
}
