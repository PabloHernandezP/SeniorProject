import 'package:equine_ai/pages/dashboard/widgets/charts/bar_chart.dart';
import 'package:equine_ai/pages/dashboard/widgets/charts/line_chart.dart';
import 'package:equine_ai/pages/dashboard/widgets/charts/pie_chart.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Parameter extends StatelessWidget {
  final double data;
  final String name;
  final String type;
  final Color color;

  const Parameter({
    Key? key,
    required this.data,
    required this.name,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height / 2;
    double maxWidth = MediaQuery.of(context).size.width / 3.5;

    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    if (isWebMobile) {
      maxHeight = MediaQuery.of(context).size.height / 2;
      maxWidth = MediaQuery.of(context).size.width / 2.5;
    }

    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: gaitParameterName,
              ),
              if (type == 'LineChart')
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: MyLineChart(
                    chartHeight: maxHeight - 10,
                    chartWidth: maxWidth - 10,
                  ),
                ),
              if (type == 'BarChart')
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: MyBarChart(
                    chartHeight: maxHeight - 10,
                    chartWidth: maxWidth - 10,
                  ),
                ),
              if (type == 'PieChart')
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: MyPieChart(
                    chartHeight: maxHeight - 10,
                    chartWidth: maxWidth - 10,
                  ),
                ),
              if (type == 'ConformationData')
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: MyLineChart(
                    chartHeight: maxHeight - 10,
                    chartWidth: maxWidth - 10,
                  ),
                ),
              Text(
                data.toString(),
                style: neutralResult,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
