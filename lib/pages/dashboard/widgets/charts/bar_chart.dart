import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarChart extends StatelessWidget {
  const MyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceEvenly,
          groupsSpace: .3,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  y: 10,
                  colors: [Colors.blue],
                ),
                BarChartRodData(
                  y: 15,
                  colors: [Colors.green],
                ),
                BarChartRodData(
                  y: 20,
                  colors: [Colors.red],
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  y: 5,
                  colors: [Colors.blue],
                ),
                BarChartRodData(
                  y: 10,
                  colors: [Colors.green],
                ),
                BarChartRodData(
                  y: 15,
                  colors: [Colors.red],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}