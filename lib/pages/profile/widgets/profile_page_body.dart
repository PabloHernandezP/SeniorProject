import 'package:equine_ai/pages/profile/widgets/personal_profile.dart';
import 'package:equine_ai/styles/dashboard_styles.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  final String firstHeading = "Personal Profile";
  final String secondHeading = "Equine Profiles";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHeight / 8,
          child: Text(
            firstHeading,
            style: heading,
          ),
        ),
        SizedBox(
          height: screenHeight / 3,
          child: const PersonalProfile(),
        ),
        SizedBox(
          height: screenHeight / 8,
          child: Text(
            secondHeading,
            style: heading,
          ),
        ),
      ],
    );
  }
}
