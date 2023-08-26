import 'package:flutter/material.dart';
import 'package:flutter_openweather_app/consts/app_consts.dart';
import 'package:flutter_openweather_app/widgets/current_info_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.size,
    required this.image,
    required this.temp,
    required this.cityName,
    required this.country,
    required this.humidity,
    required this.windDirection,
    required this.speed,
    required this.description,
    required this.date,
  });

  final Size size;
  final String image;
  final String temp;
  final String description;
  final String cityName;
  final String country;
  final String humidity;
  final String windDirection;
  final String speed;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.76,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientColor, gradientColor2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          '$temp °C',
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: kTextColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
            color: kTextColor,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Image.asset(
          image,
          width: size.width * 0.5,
        ),
        const SizedBox(
          height: 28,
        ),
        Text(
          '$cityName, $country',
          style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              color: kTextColor,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
            color: kTextColor,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            CurrentInfoWidget(
                text: '$humidity %', image: 'assets/img/humidity.png'),
            CurrentInfoWidget(
                text: '$windDirection °', image: 'assets/img/windy.png'),
            CurrentInfoWidget(text: '$speed km/h', image: 'assets/img/wind.png')
          ],
        )
      ]),
    );
  }
}
