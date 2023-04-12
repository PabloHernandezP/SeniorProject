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

    return Column(
      children: [
        Text(
          firstHeading,
          style: heading,
        ),
        SizedBox(
          height: screenHeight / 5,
          child: const PersonalProfile(),
        ),
        Text(
          secondHeading,
          style: heading,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
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
    );
  }
}
