import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:firebase_database/firebase_database.dart';

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
              Text(historyEntryData.date),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  DatabaseReference myRef = FirebaseDatabase.instance
                      .ref()
                      .child(
                          "/users/seb/horse/output/2023-04-13_19:32:02/csv_url");
                  DatabaseEvent event = await myRef.once();
                  var url = event.snapshot.value;
                  html.AnchorElement anchorElement =
                      new html.AnchorElement(href: url.toString());
                  anchorElement.click();
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
  final String date;

  HistoryEntryData({
    required this.title,
    required this.date,
  });
}
