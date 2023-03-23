import 'package:equine_ai/pages/dashboard/widgets/charts/bar_chart.dart';
import 'package:equine_ai/pages/dashboard/widgets/charts/line_chart.dart';
import 'package:equine_ai/pages/dashboard/widgets/charts/pie_chart.dart';
import 'package:flutter/material.dart';

class MyDataWidget extends StatelessWidget {
  final double data;
  final String label;
  final String type;
  final Color color;

  const MyDataWidget({
    Key? key,
    required this.data,
    required this.label,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (type == 'LineChart' || type == 'BarChart')
                  ? const SizedBox(width: 5)
                  : const SizedBox(width: 35),
              (type == 'LineChart')
                  ? const MyLineChart()
                  : (type == 'PieChart')
                  ? const MyPieChart()
                  : const MyBarChart(),
              (type == 'LineChart' || type == 'BarChart')
                  ? const SizedBox(width: 45)
                  : const SizedBox(width: 35),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}