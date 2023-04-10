import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class SimpleData extends StatelessWidget {
  const SimpleData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: Center(
        child: Text(
          "12 Inches",
          style: simpleData,
        ),
      ),
    );
  }
}
