import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatelessWidget {
  final double chartHeight;
  final double chartWidth;

  const MyLineChart(
      {super.key, required this.chartHeight, required this.chartWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chartWidth,
      height: chartHeight,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(1, 3),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 8),
                FlSpot(6, 10),
              ],
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}
