import 'package:equine_ai/styles/profile_styles.dart';
import 'package:flutter/material.dart';
import 'equine_profile_edit_dialog.dart';

class EquineProfile extends StatefulWidget {
  final Function(EquineProfile)? onRemove;

  const EquineProfile({super.key, this.onRemove});

  @override
  _EquineProfileState createState() => _EquineProfileState();
}

class _EquineProfileState extends State<EquineProfile> {
  String _name = 'New Horse';
  String _breed = ' ';
  String _color = ' ';
  String _yearOfBirth = ' ';
  String _sex = ' ';
  String _discipline = ' ';
  String _competitionLevel = ' ';

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

      // write new state to DB here
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
