import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPieChart extends StatelessWidget {
  final double chartHeight;
  final double chartWidth;

  const MyPieChart({
    super.key,
    required this.chartHeight,
    required this.chartWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chartHeight,
      width: chartWidth,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              title: 'A',
              value: 25,
              color: Colors.blue,
            ),
            PieChartSectionData(
              title: 'B',
              value: 50,
              color: Colors.green,
            ),
            PieChartSectionData(
              title: 'C',
              value: 25,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
