import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
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
    on<ChangeWeather>(_changeWeather);
    //on<GetForcastTime>(_etForcastTime);

    add(GetWeather());
    add(AutoCallWeather());
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
      add(ChangeWeather());
      add(GetDate());
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
    Timer.periodic(const Duration(minutes: 5), (timer) {
      add(GetWeather());
      print(timer.tick);
      // counter--;
      // if (counter == 0) {
      //   print('Cancel timer');
      //   timer.cancel();
      // }
    });
  }

  FutureOr<void> _changeWeather(ChangeWeather event, Emitter<HomeState> emit) {
    WeatherType getWeatherType(String? type) {
      if (state.weather.current!.isDay == 0) {
        switch (type) {
          case 'Clear':
            return WeatherType.sunnyNight;
          case 'Patchy rain possible':
            return WeatherType.lightRainy;
          case 'Mist':
            return WeatherType.foggy;
          case 'Partly cloudy':
            return WeatherType.cloudyNight;
          case 'Thundery outbreaks possible':
            return WeatherType.thunder;
          case 'Light rain shower':
            return WeatherType.lightRainy;
          case 'Heavy rain':
            return WeatherType.heavyRainy;
          case 'Light rain':
            return WeatherType.lightRainy;
          case 'Moderate or heavy rain shower':
            return WeatherType.heavyRainy;
          case 'Moderate or heavy snow showers':
            return WeatherType.heavySnow;
          case 'Moderate rain':
            return WeatherType.middleRainy;
          case 'Overcast':
            return WeatherType.overcast;
          case 'Dusty':
            return WeatherType.dusty;
          case 'Foggy':
            return WeatherType.foggy;
          case 'Hazy':
            return WeatherType.hazy;
          case 'Cloudy':
            return WeatherType.cloudyNight;
          case 'Heavy Snow':
            return WeatherType.heavySnow;
        }
      } else {
        switch (type) {
          case 'Clear':
            return WeatherType.sunny;
          case 'Patchy rain possible':
            return WeatherType.lightRainy;
          case 'Mist':
            return WeatherType.foggy;
          case 'Partly cloudy':
            return WeatherType.cloudy;
          case 'Thundery outbreaks possible':
            return WeatherType.thunder;
          case 'Light rain shower':
            return WeatherType.lightRainy;
          case 'Heavy rain':
            return WeatherType.heavyRainy;
          case 'Light rain':
            return WeatherType.lightRainy;
          case 'Moderate or heavy rain shower':
            return WeatherType.heavyRainy;
          case 'Moderate or heavy snow showers':
            return WeatherType.heavySnow;
          case 'Moderate rain':
            return WeatherType.middleRainy;
          case 'Overcast':
            return WeatherType.overcast;
          case 'Dusty':
            return WeatherType.dusty;
          case 'Foggy':
            return WeatherType.foggy;
          case 'Hazy':
            return WeatherType.hazy;
          case 'Cloudy':
            return WeatherType.cloudy;
          case 'Heavy Snow':
            return WeatherType.heavySnow;
        }
      }
      return WeatherType.sunny;
    }

    emit(state.copyWith(
        weatherType: getWeatherType(state.weather.current!.condition!.text)));

    // if (!state.isloading) {
    //   String epochTime = state.weather.location!.localtime!;

    //   int epochTimeInt = DateTime.parse(epochTime).millisecondsSinceEpoch;
    //   Timer.periodic(const Duration(seconds: 1), (timer) {
    //     add(GetForcastTime(getTime: epochTimeInt += 1));
    //   });
    // }
  }

  // FutureOr<void> _etForcastTime(GetForcastTime event, Emitter<HomeState> emit) {
  //   DateTime date = DateTime.fromMillisecondsSinceEpoch(event.getTime * 1000);
  //   final formatedDate = DateFormat('jms').format(date);

  //   emit(state.copyWith(forecastTime: formatedDate));
  // }
}
