import 'package:equine_ai/pages/dashboard/widgets/charts/fast_facts.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Limb extends StatelessWidget {
  final String title;
  final List<String> paramNames;
  final List<double> paramValues;

  const Limb({
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
                  facts: [
                    [
                      paramNames[0],
                      paramValues[0].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[1],
                      paramValues[1].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[2],
                      paramValues[2].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[3],
                      paramValues[3].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[4],
                      paramValues[4].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[5],
                      paramValues[5].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[6],
                      paramValues[6].toStringAsFixed(decimalPlaces)
                    ],
                    [
                      paramNames[7],
                      paramValues[7].toStringAsFixed(decimalPlaces)
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
