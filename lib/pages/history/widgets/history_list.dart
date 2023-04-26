import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/history/widgets/history_entry.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:equine_ai/styles/history_styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryList extends StatefulWidget {
  HistoryList({Key? key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final FilterController filterController = Get.find();
  final authService = Get.find<AuthController>();
  final Set<HistoryEntryData> _historyEntries = {};

  String? selectedHorse = null;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadHistoryEntries() async {
    DatabaseReference historyRef = databaseReference
        .child('users')
        .child(authService.uid!.value)
        .child(filterController.getSelectedHorse()!)
        .child('output');
    historyRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;

      if (!dataSnapshot.exists) {
        return;
      }

      Map<String, dynamic>? historyData =
          dataSnapshot.value as Map<String, dynamic>?;

      if (historyData != null) {
        for (var key in historyData.keys) {
          var entry = historyData[key];
          if (entry != null) {
            setState(
              () {
                _historyEntries.add(
                  HistoryEntryData(
                    title: entry['video_name'][0],
                    date: key,
                    csvUrl: entry['csv_url'][0],
                  ),
                );
              },
            );
          }
        }
      }
    });
  }

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
          if (filterController.getSelectedHorse() != selectedHorse) {
            _historyEntries.clear();
            _loadHistoryEntries();
            selectedHorse = filterController.getSelectedHorse();
          }
          if (_historyEntries.isEmpty) {
            return Center(
              child: Text(
                'No History for Selected Horse',
                style: emptyHistory,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _historyEntries.length,
                itemBuilder: (context, index) {
                  return HistoryEntry(
                    historyEntryData: _historyEntries.toList()[index],
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
