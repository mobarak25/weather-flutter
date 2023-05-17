import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/utilities.dart';
import 'package:weather/features/app/domain/entities/weather.dart';
import 'package:weather/features/app/domain/repositories/api_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._apiRepo) : super(HomeInitial()) {
    on<GetWeather>(_getWeather);
    on<GetDate>(_getDate);

    add(GetWeather());
  }

  final ApiRepo _apiRepo;

  FutureOr<void> _getWeather(GetWeather event, Emitter<HomeState> emit) async {
    final body = {
      'mobile': '01767513948',
      'password': '123456789',
      'device_name': 'IPhone'
    };
    final response = await _apiRepo.post(
        endpoint: "?key=05723c6f77864e33a1b60712231305&q=auto:ip&days=7",
        body: body,
        responseModal: const Weather());
    if (response != null) {
      emit(state.copyWith(weather: response));
      add(GetDate());
    }
  }

  FutureOr<void> _getDate(GetDate event, Emitter<HomeState> emit) {
    emit(state.copyWith(date: getDate(state.weather.current!.lastUpdated!)));
  }
}
