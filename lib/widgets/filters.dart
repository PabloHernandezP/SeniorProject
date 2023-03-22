import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String _selectedSpecimen = 'Specimen A';
  String _selectedTimeframe = 'Last 24 Hours';

  final List<String> _specimens = [
    'Specimen A',
    'Specimen B',
    'Specimen C',
    'Specimen D',
    'Specimen E',
  ];

  final List<String> _timeframes = [
    'Last 24 Hours',
    'Last 7 Days',
    'Last 30 Days',
    'Last 90 Days',
    'All Time',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String>(
          value: _selectedSpecimen,
          onChanged: (String? newValue) {
            setState(() {
              _selectedSpecimen = newValue!;
            });
          },
          items: _specimens
              .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
              .toList(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          underline: Container(
            height: 2.0,
            color: Colors.blueAccent,
          ),
          dropdownColor: Colors.blue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 20,
        ),
        DropdownButton<String>(
          value: _selectedTimeframe,
          onChanged: (String? newValue) {
            setState(() {
              _selectedTimeframe = newValue!;
            });
          },
          items: _timeframes
              .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
              .toList(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          underline: Container(
            height: 2.0,
            color: Colors.blueAccent,
          ),
          dropdownColor: Colors.blue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 20,
        ),
      ],
    );
  }
}
