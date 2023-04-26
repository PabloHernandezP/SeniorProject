import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:equine_ai/pages/dashboard/widgets/parameters/limb.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConformationList extends StatefulWidget {
  ConformationList({super.key});

  @override
  State<ConformationList> createState() => _ConformationListState();
}

class _ConformationListState extends State<ConformationList> {
  final filterController = Get.find();
  final authService = Get.find<AuthController>();

  Future<List<String>> readData(String horseName) async {
    List<String> latestData = [];
    List<String> historicAvg = [];

    DatabaseReference dataRef = databaseReference
        .child('users')
        .child(authService.uid!.value)
        .child('Pablo')
        .child('output');

    DatabaseReference avgRef = databaseReference
        .child('users')
        .child(authService.uid!.value)
        .child('Pablo')
        .child('output')
        .child('historic_average');

    dataRef.onValue.first.then(
      (DatabaseEvent event) {
        DataSnapshot dataSnapshot = event.snapshot;
        Map<String, dynamic>? outputData =
            dataSnapshot.value as Map<String, dynamic>?;

        if (outputData != null) {
          for (var key in outputData.keys) {
            var currData = outputData[key];
            if (currData != null) {
              if (key != 'historic_average') {
                latestData.clear();
                latestData.add(currData['AvgForeLegLength']);
                latestData.add(currData['AvgForeLimbLength']);
                latestData.add(currData['AvgHeadLength']);
                latestData.add(currData['AvgHindLegLength']);
                latestData.add(currData['AvgHindLimbLength']);
                latestData.add(currData['AvgHindNeckLength']);
                latestData.add(currData['AvgHindShankLength']);
                latestData.add(currData['MaxForeLegLength']);
                latestData.add(currData['MaxForeLimbLength']);
                latestData.add(currData['MaxHeadLength']);
                latestData.add(currData['MaxHindLegLength']);
                latestData.add(currData['MaxHindLimbLength']);
                latestData.add(currData['MaxNeckLength']);
                latestData.add(currData['MaxShankLength']);
                latestData.add(currData['MinForeLegLength']);
                latestData.add(currData['MinForeLimbLength']);
                latestData.add(currData['MinHeadLength']);
                latestData.add(currData['MinHindLegLength']);
                latestData.add(currData['MinHindLimbLength']);
                latestData.add(currData['MinNeckLength']);
                latestData.add(currData['MinShankLength']);
                latestData.add(currData['STDForeLegLength']);
                latestData.add(currData['STDForeLimbLength']);
                latestData.add(currData['STDHeadLength']);
                latestData.add(currData['STDHindLegLength']);
                latestData.add(currData['STDHindLimbLength']);
                latestData.add(currData['STDNeckLength']);
                latestData.add(currData['STDShankLength']);
              }
            }
          }
        }
      },
    );

    avgRef.onValue.first.then(
      (DatabaseEvent event) {
        DataSnapshot dataSnapshot = event.snapshot;
        Map<String, dynamic>? avgData =
            dataSnapshot.value as Map<String, dynamic>?;

        if (avgData != null) {
          for (var key in avgData.keys) {
            historicAvg.add(avgData[key]);
          }
        }
      },
    );

    List<String> combinedList = latestData + historicAvg;
    return combinedList;
  }

  Future<List<String>> readHistoricAverages(String horseName) async {
    List<String> historicAvg = [];

    DatabaseReference avgRef = databaseReference
        .child('users')
        .child(authService.uid!.value)
        .child(filterController.selectedHorse.value)
        .child('output')
        .child('historic_average');

    avgRef.onValue.first.then(
      (DatabaseEvent event) {
        DataSnapshot dataSnapshot = event.snapshot;
        Map<String, dynamic>? avgData =
            dataSnapshot.value as Map<String, dynamic>?;

        if (avgData != null) {
          for (var key in avgData.keys) {
            historicAvg.add(avgData[key]);
          }
        }
      },
    );

    return historicAvg;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => filterController.selectedHorse.value == ''
          ? const Center(
              child: Text('Please select a horse.'),
            )
          : FutureBuilder<List<String>>(
              future: readData(filterController.selectedHorse.value),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return ListView(
                    children: const [
                      Limb(
                        paramNames: [
                          "Avg Limb Length",
                          "Avg Leg Length",
                          "Max Limb Length",
                          "Max Leg Length",
                          "Min Limb Length",
                          "Min Leg Length",
                          "STD Limb Length",
                          "STD Leg Length",
                        ],
                        paramValues: [],
                        title: 'Fore Limb',
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }
}
