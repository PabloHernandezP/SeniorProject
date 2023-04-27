import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'parameters/parameter.dart';

class ParameterList extends StatelessWidget {
  ParameterList({super.key});

  final bool isWebMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    const List<Widget> widgets = [
      Parameter(
        data: 80,
        name: 'Strike Angle',
        type: 'LineChart',
        color: Colors.green,
      ),
      Parameter(
        data: 15,
        name: 'Stride Length',
        type: 'PieChart',
        color: Colors.yellow,
      ),
      Parameter(
        data: 45,
        name: 'Stance Time',
        type: 'BarChart',
        color: Colors.red,
      ),
      Parameter(
        data: 45,
        name: 'Extra Thing',
        type: 'BarChart',
        color: Colors.red,
      ),
      Parameter(
        data: 45,
        name: 'Conformation Data',
        type: 'FastFacts',
        color: Colors.red,
      ),
    ];

    int widgetsPerRow = 3;
    if (isWebMobile) {
      widgetsPerRow = 2;
    }

    return ListView.builder(
      itemCount: (widgets.length / widgetsPerRow).ceil(),
      itemBuilder: (BuildContext context, int index) {
        int startIndex = index * widgetsPerRow;
        int endIndex = (index + 1) * widgetsPerRow;
        endIndex = endIndex >= widgets.length ? widgets.length : endIndex;

        return Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.spaceEvenly,
          children: widgets.sublist(startIndex, endIndex),
        );
      },
    );
  }
}
