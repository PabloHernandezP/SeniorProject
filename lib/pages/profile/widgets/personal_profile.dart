import 'package:equine_ai/pages/profile/widgets/personal_profile_edit_dialog.dart';
import 'package:equine_ai/styles/profile_styles.dart';
import 'package:flutter/material.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:get/get.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  final authService = Get.find<AuthController>();

  // String? _name = authService.name?.value;
  // String? _email = authService.email?.value;
  String _role = 'User';
  String _subscriptionStatus = 'Active';


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/equine_genetics_lab_logo.png'),
                  radius: 40,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      authService!.name!.value.toString(),
                      //_name!,
                      style: profileName,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Email: ', style: attributeCategory),
                          TextSpan(text: authService.email!.value, style: attributeValue),
                          // TextSpan(text: _email, style: attributeValue),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Role: ', style: attributeCategory),
                          TextSpan(text: _role, style: attributeValue),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Subscription Status: ',
                              style: attributeCategory),
                          TextSpan(
                              text: _subscriptionStatus, style: attributeValue),
                        ],
                      ),
                    ),
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
