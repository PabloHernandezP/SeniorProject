import 'package:equine_ai/pages/history/widgets/history_entry.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  // read history from DB to populate this
  final List<HistoryEntryData> _historyEntries = List.generate(
    5,
    (index) => HistoryEntryData(
      title: 'Analysis ${index + 1}',
      info1: 'Info1: Value ${index + 1}',
      info2: 'Info2: Value ${index + 1}',
      info3: 'Info3: Value ${index + 1}',
    ),
  );

  HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
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
}
