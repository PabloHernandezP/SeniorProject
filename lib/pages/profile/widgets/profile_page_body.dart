import 'package:equine_ai/pages/profile/widgets/personal_profile.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

import 'equine_profile.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  final List<EquineProfile> _equineProfiles = [
    const EquineProfile(),
    // read previous state from DB here
  ];

  final String firstHeading = "Personal Profile";
  final String secondHeading = "Equine Profiles";

  void _addNewEquineProfile() {
    setState(() {
      _equineProfiles.add(EquineProfile(
        onRemove: _removeEquineProfile,
      ));
    });
  }

  void _removeEquineProfile(EquineProfile equineProfile) {
    setState(() {
      _equineProfiles.remove(equineProfile);
    });
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