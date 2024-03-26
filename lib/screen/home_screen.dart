import 'package:flutter/material.dart';
import 'package:sensors_shake/const/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number;
  final double threshold;

  const HomeScreen({
    required this.number,
    required this.threshold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/img/$number.png'),
        ),
        SizedBox(height: 32.0),
        Text(
          '행운의 숫자',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          number.toString(),
          style: const TextStyle(
            color: primaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          '현재 민감도 : ${threshold.toStringAsFixed(2)}',
          style: const TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
