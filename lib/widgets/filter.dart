import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/styles/filter_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filter extends StatelessWidget {
  Filter({super.key});

  final String defaultValue = 'Select a Horse';
  final FilterController filterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<FilterController>(
          builder: (_) => DropdownButton<String>(
            focusColor: Colors.blue,
            dropdownColor: Colors.blue,
            hint: Text(
              defaultValue,
              style: filterOption,
            ),
            value: _.getSelectedHorse(),
            items: _.horseNames
                .map<DropdownMenuItem<String>>(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: filterOption,
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                filterController.setSelectedHorse(value);
              }
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 20,
        ),
      ],
    );
  }
}
