import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/dashboard/widgets/parameter_list.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/global_state_management.dart';
import '../../profile/widgets/equine_profile.dart';

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

  Future<void> _loadEquineProfiles() async {
    DatabaseReference profileRef =
        databaseReference.child('equine_profiles').child(uid!.value);
    profileRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<String, dynamic>? profilesData =
          dataSnapshot.value as Map<String, dynamic>?;

      if (profilesData != null) {
        for (var key in profilesData.keys) {
          var profile = profilesData[key];
          if (profile != null) {
            setState(() {});
            equineProfileNames.add(profile['name']).obs;
          }
        }
        filterController.update();
      }
    });
  }

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
