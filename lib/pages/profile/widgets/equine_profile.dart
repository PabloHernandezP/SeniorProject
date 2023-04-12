import 'package:flutter/material.dart';
import 'equine_profile_edit_dialog.dart';

class EquineProfile extends StatefulWidget {
  const EquineProfile({super.key});

  @override
  _EquineProfileState createState() => _EquineProfileState();
}

class _EquineProfileState extends State<EquineProfile> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _role = 'Developer';
  String _subscriptionStatus = 'Active';

  String _breed = 'Warmblood';
  String _color = 'Bay';
  String _yearOfBirth = '2010';
  String _sex = 'Male';
  String _discipline = 'Dressage';
  String _competitionLevel = 'First';

  Future<void> _editProfile(BuildContext context) async {
    final updatedInfo = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return EquineProfileEditDialog(
          name: _name,
          breed: _breed,
          color: _color,
          yearOfBirth: _yearOfBirth,
          sex: _sex,
          discipline: _discipline,
          competitionLevel: _competitionLevel,
        );
      },
    );

    if (updatedInfo != null) {
      setState(() {
        _name = updatedInfo['name']!;
        _breed = updatedInfo['breed']!;
        _color = updatedInfo['color']!;
        _yearOfBirth = updatedInfo['yearOfBirth']!;
        _sex = updatedInfo['sex']!;
        _discipline = updatedInfo['discipline']!;
        _competitionLevel = updatedInfo['competitionLevel']!;
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
                    Text('Breed: $_breed'),
                    const SizedBox(height: 4),
                    Text('Color: $_color'),
                    const SizedBox(height: 4),
                    Text('Year of Birth: $_yearOfBirth'),
                    const SizedBox(height: 4),
                    Text('Sex: $_sex'),
                    const SizedBox(height: 4),
                    Text('Discipline: $_discipline'),
                    const SizedBox(height: 4),
                    Text('Competition Level: $_competitionLevel'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _editProfile(context),
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
