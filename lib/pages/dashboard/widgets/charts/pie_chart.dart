import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
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