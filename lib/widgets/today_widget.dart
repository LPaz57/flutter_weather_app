import 'package:flutter/material.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              '7 days >',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Hubballi',
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
