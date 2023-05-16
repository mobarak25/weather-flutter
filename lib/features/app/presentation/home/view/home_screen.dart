import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/core/injection/global.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
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
                              weatherType: WeatherType.middleRainy,
                              width: size.width,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top,
                              left: 20,
                              right: 20,
                            ),
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: bWhite.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      TextB(
                                        text: state.weather.location!.name!,
                                        fontSize: 18,
                                        fontColor: bWhite,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      TextB(
                                        text: state.date,
                                        fontSize: 14,
                                        fontColor: bWhite,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 60),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text:
                                              'Feel Like: ${state.weather.current!.feelslikeC!.round()}',
                                          fontColor: bWhite,
                                        ),
                                        const SizedBox(height: 5),
                                        TextB(
                                          text:
                                              'Humidity: ${state.weather.current!.humidity!.round()}%',
                                          fontColor: bWhite,
                                        ),
                                        const SizedBox(height: 5),
                                        TextB(
                                          text:
                                              'Visibility: ${state.weather.current!.visKm!.round()} km',
                                          fontColor: bWhite,
                                        ),
                                        const SizedBox(height: 5),
                                        TextB(
                                          text:
                                              'Wind: ${state.weather.current!.windKph!.round()} km/h',
                                          fontColor: bWhite,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: bWhite.withOpacity(0.5),
                                              shape: BoxShape.circle),
                                          child: NetworkImageB(
                                            imageUrl:
                                                'https:${state.weather.current!.condition!.icon}',
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextB(
                                              text:
                                                  "${state.weather.current!.tempC!.round()}",
                                              fontSize: 50,
                                              fontColor: bRed,
                                              fontHeight: 1,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const TextB(
                                              text: "o",
                                              fontSize: 13,
                                              fontColor: bRed,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
                                        TextB(
                                          text: state.weather.current!
                                              .condition!.text!,
                                          fontColor: bWhite,
                                        ),
                                      ],
                                    ),
                                  ],
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
