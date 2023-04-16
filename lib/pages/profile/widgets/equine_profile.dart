import 'package:equine_ai/pages/login/authentication.dart';
import 'package:equine_ai/styles/profile_styles.dart';
import 'package:flutter/material.dart';
import 'equine_profile_edit_dialog.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class EquineProfile extends StatefulWidget {
  final Function(EquineProfile)? onRemove;
  final String? profileKey; // Add this line
  final String? name;
  final String? breed;
  final String? color;
  final String? yearOfBirth;
  final String? sex;
  final String? discipline;
  final String? competitionLevel;
  final void Function(String oldName, String newName)? onNameUpdate;

  const EquineProfile({
    Key? key,
    this.onRemove,
    this.profileKey, // Add this line
    this.name,
    this.breed,
    this.color,
    this.yearOfBirth,
    this.sex,
    this.discipline,
    this.competitionLevel,
    this.onNameUpdate,
  }) : super(key: key);


  @override
  _EquineProfileState createState() => _EquineProfileState(
    profileKey: profileKey, // Add this line
    name: name,
    breed: breed,
    color: color,
    yearOfBirth: yearOfBirth,
    sex: sex,
    discipline: discipline,
    competitionLevel: competitionLevel,
  );
}


class _EquineProfileState extends State<EquineProfile> {
  final authService = Get.find<AuthController>();

  final String? _profileKey;
  String _name = 'New Horse';
  String _breed = ' ';
  String _color = ' ';
  String _yearOfBirth = ' ';
  String _sex = ' ';
  String _discipline = ' ';
  String _competitionLevel = ' ';
  final void Function(String oldName, String newName)? onNameUpdate;

  _EquineProfileState({
    String? profileKey, // Add this line
    String? name,
    String? breed,
    String? color,
    String? yearOfBirth,
    String? sex,
    String? discipline,
    String? competitionLevel,
    this.onNameUpdate,
  })  : _profileKey = profileKey, // Add this line
        _name = name ?? 'New Horse',
        _breed = breed ?? ' ',
        _color = color ?? ' ',
        _yearOfBirth = yearOfBirth ?? ' ',
        _sex = sex ?? ' ',
        _discipline = discipline ?? ' ',
        _competitionLevel = competitionLevel ?? ' ';


  final databaseReference = FirebaseDatabase.instance.reference();


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
      String oldName = _name;
      setState(() {
        _name = updatedInfo['name']!;
        _breed = updatedInfo['breed']!;
        _color = updatedInfo['color']!;
        _yearOfBirth = updatedInfo['yearOfBirth']!;
        _sex = updatedInfo['sex']!;
        _discipline = updatedInfo['discipline']!;
        _competitionLevel = updatedInfo['competitionLevel']!;
      });

      // Call the onNameUpdate callback if it's not null
      onNameUpdate?.call(oldName, _name);

      // Write new state to DB here
      String userId = authService.uid!.value;
      String profileKey = _profileKey ?? '';
      Map<String, String> equineProfileData = {
        'name': _name,
        'breed': _breed,
        'color': _color,
        'yearOfBirth': _yearOfBirth,
        'sex': _sex,
        'discipline': _discipline,
        'competitionLevel': _competitionLevel,
      };

      await databaseReference
          .child('equine_profiles')
          .child(userId)
          .child(profileKey)
          .update(equineProfileData);

      // Update local and global lists
      authService.equineProfileNames.remove(oldName); // Move this line here
      authService.equineProfileNames.add(updatedInfo['name']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth / 2.5,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/equine_genetics_lab_logo.png'),
                    radius: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 6,
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
                            TextSpan(text: 'Breed: ', style: attributeCategory),
                            TextSpan(text: _breed, style: attributeValue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Color: ', style: attributeCategory),
                            TextSpan(text: _color, style: attributeValue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Year of Birth: ',
                                style: attributeCategory),
                            TextSpan(text: _yearOfBirth, style: attributeValue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Sex: ', style: attributeCategory),
                            TextSpan(text: _sex, style: attributeValue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Discipline: ', style: attributeCategory),
                            TextSpan(text: _discipline, style: attributeValue),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Competition Level: ',
                                style: attributeCategory),
                            TextSpan(
                                text: _competitionLevel, style: attributeValue),
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
                    tooltip: 'Edit equine profile',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => widget.onRemove?.call(widget),
                    icon: const Icon(Icons.remove_circle),
                    tooltip: 'Remove equine profile',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
