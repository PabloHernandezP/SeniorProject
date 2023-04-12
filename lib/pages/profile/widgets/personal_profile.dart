import 'package:equine_ai/pages/profile/widgets/personal_profile_edit_dialog.dart';
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
              const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/equine_genetics_lab_logo.png'),
                radius: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(_email),
                    const SizedBox(height: 4),
                    Text(_role),
                    const SizedBox(height: 4),
                    Text('Subscription Status: $_subscriptionStatus'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _editProfile(context),
                icon: const Icon(Icons.edit),
                tooltip: 'Edit your profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
