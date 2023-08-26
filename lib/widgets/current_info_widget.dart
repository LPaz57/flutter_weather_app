import 'package:flutter/material.dart';
import 'package:flutter_openweather_app/consts/app_consts.dart';

class CurrentInfoWidget extends StatelessWidget {
  const CurrentInfoWidget({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(
            image,
            width: 30,
            height: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
              color: kTextColor,
            ),
          )
        ],
      ),
    );
  }
}
