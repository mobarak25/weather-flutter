import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
import 'package:weather/features/app/domain/entities/weather.dart';
import 'package:weather/features/app/presentation/home/bloc/home_bloc.dart';

class WeatherBanner extends StatelessWidget {
  const WeatherBanner(
      {required this.weather,
      required this.date,
      this.isloading = false,
      required this.weatherType,
      super.key});
  final Weather weather;
  final String date;
  final bool isloading;
  final WeatherType weatherType;
  // final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<HomeBloc>();
    return Stack(
      children: [
        ClipRRect(
          child: WeatherBg(
            height: size.height * 0.45,
            weatherType: weatherType,
            width: size.width,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  if (isloading)
                    const LinearProgressIndicator(
                      minHeight: 1,
                      color: bRed,
                      backgroundColor: bDark,
                    ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: bWhite.withOpacity(0.1)),
                    child: Row(
                      children: [
                        const TextB(
                          text: "Weather Forecast",
                          fontSize: 19,
                          fontColor: bWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            bloc.add(GetMyLocation());
                          },
                          child: const Icon(
                            Icons.location_searching,
                            size: 22,
                            color: bWhite,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            bloc.add(CallLocationModal());
                          },
                          child: const Icon(
                            Icons.search,
                            size: 28,
                            color: bWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    color: bWhite.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextB(
                      text:
                          '${weather.location!.name!}, ${weather.location!.country!}',
                      fontSize: 20,
                      fontColor: bWhite,
                      fontWeight: FontWeight.w500,
                    ),
                    TextB(
                      text: date,
                      fontSize: 16,
                      fontColor: bWhite,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextB(
                          text:
                              'Feel Like: ${weather.current!.feelslikeC!.round()}',
                          fontSize: 20,
                          fontColor: bWhite,
                        ),
                        const SizedBox(height: 10),
                        TextB(
                          text:
                              'Humidity: ${weather.current!.humidity!.round()}%',
                          fontSize: 20,
                          fontColor: bWhite,
                        ),
                        const SizedBox(height: 10),
                        TextB(
                          text:
                              'Visibility: ${weather.current!.visKm!.round()} km',
                          fontSize: 20,
                          fontColor: bWhite,
                        ),
                        const SizedBox(height: 10),
                        TextB(
                          text:
                              'Wind: ${weather.current!.windKph!.round()} km/h',
                          fontSize: 20,
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
                                'https:${weather.current!.condition!.icon}',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextB(
                              text: "${weather.current!.tempC!.round()}",
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
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: TextB(
                            text: weather.current!.condition!.text!,
                            maxLines: 1,
                            fontColor: bWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
