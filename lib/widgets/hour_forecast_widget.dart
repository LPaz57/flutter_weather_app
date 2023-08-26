import 'package:flutter/material.dart';

class HourForecastWidget extends StatelessWidget {
  const HourForecastWidget(
      {super.key,
      required this.image,
      required this.time,
      required this.forecastTemp});

  final String image;
  final String time;
  final String forecastTemp;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 16, 54, 75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$forecastTemp °C',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(
                  image,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
