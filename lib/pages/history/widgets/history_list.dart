import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/history/widgets/history_entry.dart';
import 'package:equine_ai/styles/history_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryList extends StatefulWidget {
  HistoryList({Key? key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  // read history from DB to populate this
  final List<HistoryEntryData> _historyEntries = List.generate(
    5,
    (index) => HistoryEntryData(
      title: 'Analysis ${index + 1}',
      date: 'Date: Value ${index + 1}',
    ),
  );

  final FilterController filterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: filterController,
      builder: (controller) {
        if (controller.getSelectedHorse() == null) {
          return Center(
            child: Text(
              'Select a Horse Above to View History',
              style: noHorseSelected,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: _historyEntries.length,
              itemBuilder: (context, index) {
                return HistoryEntry(
                  historyEntryData: _historyEntries[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
