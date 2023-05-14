import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/core/injection/global.dart';
import 'package:weather/features/app/domain/repositories/api_repo.dart';
import 'package:weather/features/app/presentation/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1a1c1e),
      body: Container(
        child: BlocProvider(
          create: (context) => HomeBloc(getIt<ApiRepo>()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final bloc = context.read<HomeBloc>();
              final size = MediaQuery.of(context).size;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  WeatherBg(
                    height: size.height * 0.5,
                    weatherType: WeatherType.cloudyNight,
                    width: size.width,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
