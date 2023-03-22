import 'package:equine_ai/pages/dashboard/widgets/data_grid.dart';
import 'package:equine_ai/pages/dashboard/widgets/specifiers.dart';
import 'package:flutter/material.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Specifiers(),
          SizedBox(height: 16.0),
          DataGrid(),
        ],
      ),
    );
  }
}
