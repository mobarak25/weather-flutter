import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/injection/global.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/utils/utilities.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
import 'package:weather/features/app/domain/repositories/api_repo.dart';
import 'package:weather/features/app/presentation/home/bloc/home_bloc.dart';
import 'package:weather/features/app/presentation/home/widget/banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFF1a1c1e),
      body: BlocProvider(
        create: (context) => HomeBloc(getIt<ApiRepo>()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.weather.current != null
                ? Column(
                    children: [
                      WeatherBanner(
                        weather: state.weather,
                        date: state.date,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: const BoxDecoration(
                          color: bLightDark,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextB(
                              text: "Weather by hour",
                              fontSize: 18,
                              fontColor: bWhite,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    state.weather.forecast!.forecastday![0]
                                        .hour!.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextB(
                                                text:
                                                    '${state.weather.forecast!.forecastday![0].hour![index].tempC!.round()}',
                                                fontSize: 16,
                                                fontColor: bWhite,
                                              ),
                                              const TextB(
                                                text: 'o',
                                                fontSize: 11,
                                                fontColor: bWhite,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: bWhite.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: NetworkImageB(
                                                imageUrl:
                                                    'https:${state.weather.forecast!.forecastday![0].hour![index].condition!.icon}'),
                                          ),
                                          const SizedBox(height: 5),
                                          TextB(
                                            text: getTime(state
                                                .weather
                                                .forecast!
                                                .forecastday![0]
                                                .hour![index]
                                                .time!),
                                            fontSize: 16,
                                            fontColor: bWhite,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: const BoxDecoration(
                            color: bLightDark,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextB(
                                text: "Next 7 day's weather",
                                fontSize: 18,
                                fontColor: bWhite,
                                fontWeight: FontWeight.w500,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        state.weather.forecast!.forecastday!
                                            .length,
                                        (index) => Row(
                                          children: [
                                            TextB(
                                              text: getDateByDay(
                                                  '${state.weather.forecast!.forecastday![index].date}'),
                                              fontColor: bWhite,
                                            ),
                                            Container(
                                              width: 33,
                                              height: 33,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: NetworkImageB(
                                                  imageUrl:
                                                      'https:${state.weather.forecast!.forecastday![index].day!.condition!.icon}'),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextB(
                                                  text:
                                                      "${state.weather.forecast!.forecastday![index].day!.maxtempC!.round()}",
                                                  fontSize: 18,
                                                  fontColor: bWhite,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const TextB(
                                                  text: "o",
                                                  fontSize: 11,
                                                  fontColor: bWhite,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              width: 30,
                                              child: const Divider(
                                                height: 1,
                                                thickness: 1,
                                                color: bWhite,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextB(
                                                  text:
                                                      "${state.weather.forecast!.forecastday![index].day!.mintempC!.round()}",
                                                  fontSize: 16,
                                                  fontColor:
                                                      bWhite.withOpacity(0.2),
                                                ),
                                                TextB(
                                                  text: "o",
                                                  fontSize: 11,
                                                  fontColor:
                                                      bWhite.withOpacity(0.2),
                                                ),
                                                TextB(
                                                  text: "C",
                                                  fontSize: 16,
                                                  fontColor:
                                                      bWhite.withOpacity(0.2),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
