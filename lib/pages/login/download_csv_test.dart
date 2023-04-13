import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:firebase_database/firebase_database.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async { 
                DatabaseReference myRef = FirebaseDatabase.instance.ref().child("/users/seb/horse/output/2023-04-13_19:32:02/csv_url");
                DatabaseEvent event = await myRef.once();
                var url = event.snapshot.value;
                html.AnchorElement anchorElement =  new html.AnchorElement(href: url.toString());
                anchorElement.click();
            },
            child: Text('Download'),
            ),
      ),
    );
  }
}