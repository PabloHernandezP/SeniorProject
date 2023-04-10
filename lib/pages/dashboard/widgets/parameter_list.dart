import 'package:flutter/material.dart';
import 'parameter.dart';

class ParameterList extends StatelessWidget {
  const ParameterList({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the widgets to be displayed in the horizontal list
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
    ];

    int widgetsPerRow = 3;

    // Create a horizontal list using the ListView widget
    return ListView.builder(
      itemCount: (widgets.length / widgetsPerRow).ceil(),
      itemBuilder: (BuildContext context, int index) {
        int startIndex = index * widgetsPerRow;
        int endIndex = (index + 1) * widgetsPerRow;
        endIndex = endIndex >= widgets.length ? widgets.length : endIndex;

        return Wrap(
          spacing: 8.0,
          children: widgets.sublist(startIndex,
              endIndex), // Adjust the spacing between widgets as needed
        );
      },
    );
  }
}
