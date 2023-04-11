import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class FastFacts extends StatelessWidget {
  final double chartHeight;
  final double chartWidth;

  final List<List<String>> facts;

  const FastFacts(
      {super.key,
      required this.chartHeight,
      required this.chartWidth,
      required this.facts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chartWidth,
      height: chartHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var fact in facts)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '${fact[0]}: ', style: factCategory),
                      TextSpan(text: fact[1], style: factResult),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
