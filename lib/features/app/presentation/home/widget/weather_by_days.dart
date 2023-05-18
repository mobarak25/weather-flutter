import 'package:flutter/material.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/utils/utilities.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
import 'package:weather/features/app/domain/entities/weather.dart';

class WeatherByDays extends StatelessWidget {
  const WeatherByDays({required this.forecastday, super.key});

  final List<Forecastday> forecastday;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: const BoxDecoration(
          color: bLightDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextB(
              text: "Next 10 day's weather",
              fontSize: 18,
              fontColor: bWhite,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      forecastday.length,
                      (index) => Column(
                        children: [
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              TextB(
                                text:
                                    getDateByDay('${forecastday[index].date}'),
                                fontColor: bWhite,
                              ),
                              Container(
                                width: 33,
                                height: 33,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: NetworkImageB(
                                    imageUrl:
                                        'https:${forecastday[index].day!.condition!.icon}'),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextB(
                                    text:
                                        "${forecastday[index].day!.maxtempC!.round()}",
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
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: 30,
                                child: const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: bWhite,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextB(
                                    text:
                                        "${forecastday[index].day!.mintempC!.round()}",
                                    fontSize: 16,
                                    fontColor: bWhite.withOpacity(0.2),
                                  ),
                                  TextB(
                                    text: "o",
                                    fontSize: 11,
                                    fontColor: bWhite.withOpacity(0.2),
                                  ),
                                  TextB(
                                    text: "C",
                                    fontSize: 16,
                                    fontColor: bWhite.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              TextB(
                                text:
                                    "${forecastday[index].day!.condition!.text}",
                                fontSize: 16,
                                fontColor: bWhite,
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: bWhite.withOpacity(0.2),
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
    );
  }
}
