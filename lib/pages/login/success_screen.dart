import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  _SuccessScreen createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen> {
  final textController = TextEditingController();

  String databaseData = "Your text will appear here";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Success Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/equine_genetics_lab_logo.png')),
              ),
            ),
            TextField(
              controller: textController,
            ),
            TextButton(
              onPressed: () async {
                String writeAddress;
                if (getAuthInstance().currentUser == null) {
                  writeAddress = "users/nullUser";
                } else {
                  writeAddress = "users/${getAuthInstance().currentUser!.uid}";
                }

                DatabaseReference ref =
                    FirebaseDatabase.instance.ref(writeAddress);

                await ref.set({
                  "text": textController.text,
                }).then((value) {
                  const snackBar = SnackBar(
                    content: Text("Text successfully saved to database!"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }).catchError((onError) {
                  const snackBar = SnackBar(
                    content:
                        Text("Unable to save to database, please try again."),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            Text(databaseData),
            TextButton(
              onPressed: () async {
                final ref = FirebaseDatabase.instance.ref();
                final snapshot = await ref.child("users/${getAuthInstance().currentUser!.uid}").get();
                setState(() {
                  if (snapshot.exists) {
                    databaseData = snapshot.value.toString();
                  } else {
                    databaseData = "Unable to retrieve data";
                  }
                });
              },
              child: const Text(
                "Retrieve written data",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () async {
                await signOut() //TODO: SIGN OUT GOOGLE VS EMAIL
                    .then((value) => Get.off(LoginScreen()))
                    .catchError((onError) => print("Log out unsuccessful"));
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
