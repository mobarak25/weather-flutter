import 'package:flutter/material.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/utils/utilities.dart';
import 'package:weather/core/widget/network_image.dart';
import 'package:weather/core/widget/text.dart';
import 'package:weather/features/app/domain/entities/weather.dart';

class WeatherByHour extends StatelessWidget {
  const WeatherByHour(
      {required this.hours, required this.forecastTime, super.key});

  final List<Hour> hours;
  final String forecastTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        color: bLightDark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextB(
                text: "Weather by hour",
                fontSize: 18,
                fontColor: bWhite,
                fontWeight: FontWeight.w500,
              ),
              TextB(
                text: forecastTime,
                fontSize: 14,
                fontColor: bRed,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  hours.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextB(
                              text: '${hours[index].tempC!.round()}',
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
                                  'https:${hours[index].condition!.icon}'),
                        ),
                        const SizedBox(height: 5),
                        TextB(
                          text: getTime(hours[index].time!),
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
    );
  }
}
