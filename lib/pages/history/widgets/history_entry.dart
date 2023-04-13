import 'package:flutter/material.dart';

class HistoryEntry extends StatelessWidget {
  final HistoryEntryData historyEntryData;

  const HistoryEntry({Key? key, required this.historyEntryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight / 4,
      child: Center(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth / 2.5,
                height: 1,
              ),
              Text(
                historyEntryData.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 1,
                height: 10,
              ),
              const SizedBox(height: 8),
              Text(historyEntryData.info1),
              const SizedBox(height: 4),
              Text(historyEntryData.info2),
              const SizedBox(height: 4),
              Text(historyEntryData.info3),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  // read CSV from DB here
                },
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Export Results'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryEntryData {
  final String title;
  final String info1;
  final String info2;
  final String info3;

  HistoryEntryData({
    required this.title,
    required this.info1,
    required this.info2,
    required this.info3,
  });
}
