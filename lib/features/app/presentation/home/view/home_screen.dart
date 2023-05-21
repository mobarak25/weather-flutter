import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/injection/global.dart';
import 'package:weather/core/navigator/iflutter_navigator.dart';
import 'package:weather/features/app/domain/repositories/api_repo.dart';
import 'package:weather/features/app/domain/repositories/local_storage_repo.dart';
import 'package:weather/features/app/presentation/home/bloc/home_bloc.dart';
import 'package:weather/features/app/presentation/home/widget/banner.dart';
import 'package:weather/features/app/presentation/home/widget/weather_by_days.dart';
import 'package:weather/features/app/presentation/home/widget/weather_by_hour.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF1a1c1e),
      body: BlocProvider(
        create: (_) => HomeBloc(getIt<ApiRepo>(), getIt<LocalStorageRepo>(),
            getIt<IFlutterNavigator>()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.weather.current != null
                ? Column(
                    children: [
                      WeatherBanner(
                        weather: state.weather,
                        date: state.date,
                        isloading: state.isloading,
                        weatherType: state.weatherType,
                      ),
                      const SizedBox(height: 15),
                      WeatherByHour(
                        hours: state.weather.forecast!.forecastday![0].hour!,
                        forecastTime: state.forecastTime,
                      ),
                      const SizedBox(height: 10),
                      WeatherByDays(
                        forecastday: state.weather.forecast!.forecastday!,
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
