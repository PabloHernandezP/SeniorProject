import 'package:flutter/material.dart';

class DataGrid extends StatelessWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: const <Widget>[
        MyDataWidget(
          data: 25,
          label: 'Widget 1',
          color: Colors.blue,
        ),
        MyDataWidget(
          data: 50,
          label: 'Widget 2',
          color: Colors.green,
        ),
        MyDataWidget(
          data: 75,
          label: 'Widget 3',
          color: Colors.red,
        ),
        MyDataWidget(
          data: 10,
          label: 'Widget 4',
          color: Colors.orange,
        ),
        MyDataWidget(
          data: 35,
          label: 'Widget 5',
          color: Colors.purple,
        ),
        MyDataWidget(
          data: 60,
          label: 'Widget 6',
          color: Colors.teal,
        ),
        MyDataWidget(
          data: 80,
          label: 'Widget 7',
          color: Colors.amber,
        ),
        MyDataWidget(
          data: 15,
          label: 'Widget 8',
          color: Colors.cyan,
        ),
        MyDataWidget(
          data: 45,
          label: 'Widget 9',
          color: Colors.deepOrange,
        ),
      ],
    );
  }
}

class MyDataWidget extends StatelessWidget {
  final double data;
  final String label;
  final Color color;

  const MyDataWidget({
    Key? key,
    required this.data,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            data.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
