import 'package:flutter/material.dart';
import 'data_widget.dart';

class DataGrid extends StatelessWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 || index == 2) {
          final subtitle =
              index == 0 ? 'Latest Results' : 'Historical Averages';
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              MyDataWidget(
                data: 80,
                name: 'Strike Angle',
                type: 'LineChart',
                color: Colors.green,
              ),
              MyDataWidget(
                data: 15,
                name: 'Stride Length',
                type: 'PieChart',
                color: Colors.yellow,
              ),
              MyDataWidget(
                data: 45,
                name: 'Stance Time',
                type: 'BarChart',
                color: Colors.red,
              ),
            ],
          );
        }
      },
    );
  }
}
