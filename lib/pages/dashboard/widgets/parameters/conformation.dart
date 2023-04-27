import 'package:equine_ai/pages/dashboard/widgets/charts/fast_facts.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Conformation extends StatelessWidget {
  final String title;
  final List<String> paramNames;
  final List<double> paramValues;

  const Conformation({
    Key? key,
    required this.paramNames,
    required this.paramValues,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height / 2;
    double maxWidth = MediaQuery.of(context).size.width / 3.5;

    int decimalPlaces = 2;

    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    if (isWebMobile) {
      maxHeight = MediaQuery.of(context).size.height / 2;
      maxWidth = MediaQuery.of(context).size.width / 2.5;
    }

    return SizedBox(
      height: maxHeight,
      width: maxWidth,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: gaitParameterName,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: FastFacts(
                  chartHeight: maxHeight - 100,
                  chartWidth: maxWidth - 100,
                  facts: List.generate(paramNames.length, (index) {
                    return [
                      paramNames[index],
                      paramValues[index].toStringAsFixed(decimalPlaces),
                    ];
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
