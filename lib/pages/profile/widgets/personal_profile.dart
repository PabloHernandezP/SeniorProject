import 'package:equine_ai/pages/profile/widgets/personal_profile_edit_dialog.dart';
import 'package:equine_ai/styles/profile_styles.dart';
import 'package:flutter/material.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _role = 'Developer';
  String _subscriptionStatus = 'Active';

  Future<void> _editProfile(BuildContext context) async {
    final updatedInfo = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return PersonalProfileEditDialog(
          name: _name,
          email: _email,
          role: _role,
        );
      },
    );

    if (updatedInfo != null) {
      setState(() {
        _name = updatedInfo['name']!;
        _email = updatedInfo['email']!;
        _role = updatedInfo['role']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      _name,
                      style: profileName,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Email: ', style: attributeCategory),
                          TextSpan(text: _email, style: attributeValue),
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
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => _editProfile(context),
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit personal profile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
