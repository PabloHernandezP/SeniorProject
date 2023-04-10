import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class ConformationData extends StatelessWidget {
  const ConformationData({super.key});

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
