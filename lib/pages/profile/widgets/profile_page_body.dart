import 'package:equine_ai/pages/profile/widgets/personal_profile.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class ProfilePageBody extends StatefulWidget {
  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  final List<PersonalProfile> _personalProfiles = [
    const PersonalProfile(),
  ];

  final String firstHeading = "Personal Profile";
  final String secondHeading = "Equine Profiles";

  void _addNewUserProfileCard() {
    setState(() {
      _personalProfiles.add(const PersonalProfile());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHeight / 10,
          child: Text(
            firstHeading,
            style: heading,
          ),
        ),
        SizedBox(
          height: screenHeight / 5,
          child: const PersonalProfile(),
        ),
        SizedBox(
          height: screenHeight / 10,
          child: Text(
            secondHeading,
            style: heading,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: _personalProfiles,
            ),
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _addNewUserProfileCard,
          tooltip: 'Add new user profile card',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
