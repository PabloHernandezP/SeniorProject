import 'package:flutter/material.dart';

class EquineProfileEditDialog extends StatefulWidget {
  final String name;
  final String breed;
  final String color;
  final String yearOfBirth;
  final String sex;
  final String discipline;
  final String competitionLevel;

  const EquineProfileEditDialog(
      {super.key,
      required this.breed,
      required this.color,
      required this.yearOfBirth,
      required this.sex,
      required this.discipline,
      required this.competitionLevel,
      required this.name});

  @override
  _EquineProfileEditDialogState createState() =>
      _EquineProfileEditDialogState();
}

class _EquineProfileEditDialogState extends State<EquineProfileEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _colorController;
  late TextEditingController _yearOfBirthController;
  late TextEditingController _sexController;
  late TextEditingController _disciplineController;
  late TextEditingController _competitionLevelController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _breedController = TextEditingController(text: widget.breed);
    _colorController = TextEditingController(text: widget.color);
    _yearOfBirthController = TextEditingController(text: widget.yearOfBirth);
    _sexController = TextEditingController(text: widget.sex);
    _disciplineController = TextEditingController(text: widget.discipline);
    _competitionLevelController =
        TextEditingController(text: widget.competitionLevel);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _colorController.dispose();
    _yearOfBirthController.dispose();
    _sexController.dispose();
    _disciplineController.dispose();
    _competitionLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Equine Profile'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: 'Breed'),
            ),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: _yearOfBirthController,
              decoration: const InputDecoration(labelText: 'Year of Birth'),
            ),
            TextField(
              controller: _sexController,
              decoration: const InputDecoration(labelText: 'Sex'),
            ),
            TextField(
              controller: _disciplineController,
              decoration: const InputDecoration(labelText: 'Discipline'),
            ),
            TextField(
              controller: _competitionLevelController,
              decoration: const InputDecoration(labelText: 'Competition Level'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'name': _nameController.text,
              'breed': _breedController.text,
              'color': _colorController.text,
              'yearOfBirth': _yearOfBirthController.text,
              'sex': _sexController.text,
              'discipline': _disciplineController.text,
              'competitionLevel': _competitionLevelController.text,
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
