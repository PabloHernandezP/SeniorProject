import 'package:flutter/material.dart';

class Specifiers extends StatefulWidget {
  const Specifiers({super.key});

  @override
  _SpecifiersState createState() => _SpecifiersState();
}

class _SpecifiersState extends State<Specifiers> {
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
            color: Colors.black,
            fontSize: 16.0,
          ),
          underline: Container(
            height: 2.0,
            color: Colors.blueAccent,
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36.0,
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
            color: Colors.black,
            fontSize: 16.0,
          ),
          underline: Container(
            height: 2.0,
            color: Colors.blueAccent,
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36.0,
        ),
      ],
    );
  }
}
