import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/dashboard/widgets/parameter_list.dart';
import 'package:equine_ai/pages/dashboard/widgets/parameters/limb.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/global_state_management.dart';
import '../../profile/widgets/equine_profile.dart';
import 'conformation_list.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  void initState() {
    super.initState();
    _loadEquineProfiles();
  }

  final FilterController filterController = Get.find();
  final authService = Get.find<AuthController>();

  Future<void> _loadEquineProfiles() async {
    DatabaseReference profileRef = databaseReference
        .child('equine_profiles')
        .child(authService.uid!.value);
    profileRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<String, dynamic>? profilesData =
          dataSnapshot.value as Map<String, dynamic>?;

      if (profilesData != null) {
        for (var key in profilesData.keys) {
          var profile = profilesData[key];
          if (profile != null) {
            setState(() {});
            authService.equineProfileNames.add(profile['name']).obs;
          }
        }
        filterController.update();
      }
    });
  }

  final String firstHeading = "Conformation Parameters";
  final String secondHeading = "Locomotion Parameters";

  String? selectedHorse;
  final Set<double> parameters = {};

  Future<void> _loadParameters() async {
    DatabaseReference historyRef = databaseReference
        .child('users')
        .child(authService.uid!.value)
        .child(filterController.getSelectedHorse()!)
        .child('output');
    historyRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;

      if (!dataSnapshot.exists) {
        return;
      }

      Map<String, dynamic>? historyData =
          dataSnapshot.value as Map<String, dynamic>?;

      if (historyData != null) {
        for (var key in historyData.keys) {
          var entry = historyData[key];
          if (entry != null && key != 'historic_average') {
            setState(
              () {
                parameters.clear();
                //0
                parameters.add(entry['AvgForeLegLength'][0]);
                parameters.add(entry['AvgForeLimbLength'][0]);
                //2
                parameters.add(entry['AvgHeadLength'][0]);
                //3
                parameters.add(entry['AvgHindLegLength'][0]);
                parameters.add(entry['AvgHindLimbLength'][0]);
                //5
                parameters.add(entry['AvgNeckLength'][0]);
                //6
                parameters.add(entry['AvgShankLength'][0]);
                //7
                parameters.add(entry['MaxForeLimbLength'][0]);
                parameters.add(entry['MaxForeLegLength'][0]);
                //9
                parameters.add(entry['MaxHeadLength'][0]);
                //10
                parameters.add(entry['MaxHindLegLength'][0]);
                parameters.add(entry['MaxHindLimbLength'][0]);
                //12
                parameters.add(entry['MaxNeckLength'][0]);
                //13
                parameters.add(entry['MaxShankLength'][0]);
                //14
                parameters.add(entry['MinForeLegLength'][0]);
                parameters.add(entry['MinForeLimbLength'][0]);
                //16
                parameters.add(entry['MinHeadLength'][0]);
                //17
                parameters.add(entry['MinHindLegLength'][0]);
                parameters.add(entry['MinHindLimbLength'][0]);
                //19
                parameters.add(entry['MinNeckLength'][0]);
                //20
                parameters.add(entry['MinShankLength'][0]);
                //21
                parameters.add(entry['STDForeLegLength'][0]);
                parameters.add(entry['STDForeLimbLength'][0]);
                //23
                parameters.add(entry['STDHeadLength'][0]);
                //24
                parameters.add(entry['STDHindLegLength'][0]);
                parameters.add(entry['STDHindLimbLength'][0]);
                //26
                parameters.add(entry['STDNeckLength'][0]);
                //27
                parameters.add(entry['STDShankLength'][0]);
              },
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: filterController,
      builder: (controller) {
        if (controller.getSelectedHorse() == null) {
          return Center(
            child: Text(
              'Select a Horse Above to Analyze Results',
              style: heading,
            ),
          );
        } else {
          if (filterController.getSelectedHorse() != selectedHorse) {
            parameters.clear();
            _loadParameters();
            selectedHorse = filterController.getSelectedHorse();
          }
          if (parameters.isEmpty) {
            return Center(
              child: Text(
                'No Results for Selected Horse',
                style: heading,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
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
                    List<double> paramList = parameters.toList();
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView(
                        children: [
                          Limb(
                            paramNames: const [
                              "Avg Limb Length",
                              "Avg Leg Length",
                              "Max Limb Length",
                              "Max Leg Length",
                              "Min Limb Length",
                              "Min Leg Length",
                              "STD Limb Length",
                              "STD Leg Length",
                            ],
                            paramValues: [
                              paramList[0],
                              paramList[1],
                              paramList[8],
                              paramList[9],
                              paramList[14],
                              paramList[15],
                              paramList[21],
                              paramList[22],
                            ],
                            title: 'Fore Limb',
                          ),
                          Limb(
                            paramNames: const [
                              "Avg Limb Length",
                              "Avg Leg Length",
                              "Max Limb Length",
                              "Max Leg Length",
                              "Min Limb Length",
                              "Min Leg Length",
                              "STD Limb Length",
                              "STD Leg Length",
                            ],
                            paramValues: [
                              paramList[0],
                              paramList[1],
                              paramList[8],
                              paramList[9],
                              paramList[14],
                              paramList[15],
                              paramList[21],
                              paramList[22],
                            ],
                            title: 'Fore Limb 2',
                          ),
                          Limb(
                            paramNames: const [
                              "Avg Limb Length",
                              "Avg Leg Length",
                              "Max Limb Length",
                              "Max Leg Length",
                              "Min Limb Length",
                              "Min Leg Length",
                              "STD Limb Length",
                              "STD Leg Length",
                            ],
                            paramValues: [
                              paramList[0],
                              paramList[1],
                              paramList[8],
                              paramList[9],
                              paramList[14],
                              paramList[15],
                              paramList[21],
                              paramList[22],
                            ],
                            title: 'Fore Limb 3',
                          ),
                        ],
                      ),
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
              ),
            );
          }
        }
      },
    );
  }
}
