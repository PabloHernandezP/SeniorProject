import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/history/widgets/history_entry.dart';
import 'package:equine_ai/pages/login/global_state_management.dart';
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
  final List<HistoryEntryData> _historyEntries = [];

  final FilterController filterController = Get.find();

  Future<void> _loadHistoryEntries() async {
    DatabaseReference historyRef = databaseReference
        .child('users')
        .child(uid!.value)
        .child(filterController.getSelectedHorse()!)
        .child('output');
    historyRef.onValue.first.then((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
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
                    title: entry['video_name'],
                    date: entry['date'],
                    csvUrl: entry['csv_url'],
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
    _historyEntries.add(
      HistoryEntryData(
        title: "Random Video",
        date: "12/10/2023",
        csvUrl:
            "https://storage.googleapis.com/equine-ai.appspot.com/seb/horse/output/C0214.mp4_output.csv",
      ),
    );
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
          _historyEntries.clear;
          _loadHistoryEntries();

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
