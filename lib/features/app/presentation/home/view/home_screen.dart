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
      body: BlocProvider(
        create: (context) => HomeBloc(getIt<ApiRepo>()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // final bloc = context.read<HomeBloc>();
            final size = MediaQuery.of(context).size;
            return state.weather.current != null
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.05),
                            child: WeatherBg(
                              height: size.height * 0.55,
                              weatherType: WeatherType.sunny,
                              width: size.width,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top,
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  state.date,
                                ),
                              ],
                            ),
                          ),
                        ],
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
