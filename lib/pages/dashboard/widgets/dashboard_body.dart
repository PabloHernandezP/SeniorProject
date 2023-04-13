import 'package:equine_ai/pages/dashboard/widgets/parameter_list.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  final String firstHeading = "Unscaled Parameters";
  final String secondHeading = "Scaled Parameters";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              firstHeading,
              style: heading,
            ),
          );
        } else if (index == 1) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const ParameterList(),
          );
        } else if (index == 2) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              secondHeading,
              style: heading,
            ),
          );
        } else if (index == 3) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const ParameterList(),
          );
        }
      },
    );
  }
}
