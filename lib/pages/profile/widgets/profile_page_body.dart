import 'package:equine_ai/pages/profile/widgets/personal_profile.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:get/get.dart';

import 'equine_profile.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  final List<EquineProfile> _equineProfiles = [];

  get value => null;

  @override
  void initState() {
    super.initState();
    _loadEquineProfiles();
  }

  Future<void> _loadEquineProfiles() async {
    DatabaseReference profileRef = databaseReference.child('equine_profiles').child(uid!.value);
    profileRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<String, dynamic>? profilesData = dataSnapshot.value as Map<String, dynamic>?;

      if (profilesData != null) {
        for (var key in profilesData.keys) {
          var profile = profilesData[key];
          if (profile != null) {
            setState(() {
              _equineProfiles.add(EquineProfile(
                key: Key(key),
                profileKey: key,
                name: profile['name'],
                breed: profile['breed'],
                color: profile['color'],
                yearOfBirth: profile['yearOfBirth'],
                sex: profile['sex'],
                discipline: profile['discipline'],
                competitionLevel: profile['competitionLevel'],
                onRemove: _removeEquineProfile,
                onNameUpdate: (String oldName, String newName) {
                  equineProfileNames.remove(oldName);
                  equineProfileNames.add(newName);
                },
              ));
            });
            equineProfileNames.add(profile['name']).obs;
          }
        }
      }
    });
  }


  final String firstHeading = "Personal Profile";
  final String secondHeading = "Equine Profiles";

  void _addNewEquineProfile() async {
    String userId = uid!.value;
    DatabaseReference newProfileRef = await databaseReference
        .child('equine_profiles')
        .child(userId)
        .push();
    String profileKey = newProfileRef.key!;

    setState(() {
      _equineProfiles.add(EquineProfile(
        profileKey: profileKey,
        onRemove: _removeEquineProfile,
      ));
    });
  }

  void _removeEquineProfile(EquineProfile equineProfile) {
    setState(() {
      _equineProfiles.remove(equineProfile);
    });

    // Delete the entry from the database
    String userId = uid!.value;
    String profileKey = equineProfile.profileKey!; // Replace this line
    databaseReference
        .child('equine_profiles')
        .child(userId)
        .child(profileKey)
        .remove();

    // Remove the profile name from the local equine profile names list
    equineProfileNames.remove(equineProfile.name);
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight / 20,
            child: Center(
              child: Text(
                firstHeading,
                style: heading,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 5,
            width: screenWidth / 2.5,
            child: const PersonalProfile(), // read previous state from DB here
          ),
          SizedBox(
            height: screenHeight / 20,
            child: Center(
              child: Text(
                secondHeading,
                style: heading,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: _equineProfiles,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _addNewEquineProfile,
            tooltip: 'Add another horse to your profile',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
