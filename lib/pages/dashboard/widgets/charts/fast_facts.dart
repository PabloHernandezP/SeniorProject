import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class FastFacts extends StatelessWidget {
  final double chartHeight;
  final double chartWidth;

  final String fact1;
  final String fact2;
  final String fact3;
  final String fact4;

  const FastFacts(
      {super.key,
      required this.chartHeight,
      required this.chartWidth,
      required this.fact1,
      required this.fact2,
      required this.fact3,
      required this.fact4});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chartWidth,
      height: chartHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$fact1: ',
                style: factCategory,
              ),
              Text(
                fact1,
                style: factResult,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$fact2: ',
                style: factCategory,
              ),
              Text(
                fact2,
                style: factResult,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$fact3: ',
                style: factCategory,
              ),
              Text(
                fact3,
                style: factResult,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$fact4: ',
                style: factCategory,
              ),
              Text(
                fact4,
                style: factResult,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
