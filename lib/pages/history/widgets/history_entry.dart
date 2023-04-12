import 'package:flutter/material.dart';

class HistoryEntry extends StatelessWidget {
  final UserProfileAnalysis userProfileAnalysis;

  const HistoryEntry({Key? key, required this.userProfileAnalysis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfileAnalysis.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(userProfileAnalysis.info1),
            const SizedBox(height: 4),
            Text(userProfileAnalysis.info2),
            const SizedBox(height: 4),
            Text(userProfileAnalysis.info3),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // Implement your CSV export functionality here
                print('Export results for ${userProfileAnalysis.title}');
              },
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export Results'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileAnalysis {
  final String title;
  final String info1;
  final String info2;
  final String info3;

  UserProfileAnalysis({
    required this.title,
    required this.info1,
    required this.info2,
    required this.info3,
  });
}
