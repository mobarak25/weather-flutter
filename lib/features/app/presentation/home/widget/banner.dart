import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
import 'package:weather/features/app/domain/entities/weather.dart';

class WeatherBanner extends StatelessWidget {
  const WeatherBanner({required this.weather, required this.date, super.key});
  final Weather weather;
  final String date;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          child: WeatherBg(
            height: size.height * 0.5,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: bWhite.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextB(
                      text: weather.location!.name!,
                      fontSize: 18,
                      fontColor: bWhite,
                      fontWeight: FontWeight.w700,
                    ),
                    TextB(
                      text: date,
                      fontSize: 14,
                      fontColor: bWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Row(
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
                            'Visibility: ${weather.current!.visKm!.round()}km',
                        fontSize: 20,
                        fontColor: bWhite,
                      ),
                      const SizedBox(height: 10),
                      TextB(
                        text: 'Wind: ${weather.current!.windKph!.round()}km/h',
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
                          imageUrl: 'https:${weather.current!.condition!.icon}',
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
                      TextB(
                        text: weather.current!.condition!.text!,
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
    );
  }
}
