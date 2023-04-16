import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:get/get.dart';

class DisplayNameScreen extends StatefulWidget {
  const DisplayNameScreen

  ({super.key});

  @override
  _DisplayNameScreen createState() => _DisplayNameScreen();
}

class _DisplayNameScreen extends State<DisplayNameScreen> {
  final textController = TextEditingController();

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
        title: const Text("Set Display Name"),
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
            const Text(
                "Welcome to Equine.AI! Before continuing, please enter your name:"),
            TextField(
              controller: textController,
            ),
            TextButton(
              onPressed: () async {
                await getAuthInstance().currentUser?.updateDisplayName(textController.text)
                    .then((r) {
                  const snackBar = SnackBar(
                    content:
                    Text('Name set successful!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Get.off(const Dashboard());
                  //Get.off(()=>'/dashboard');
                  Get.toNamed("/dashboard");
                }).catchError((e) {
                  const snackBar = SnackBar(
                    content:
                    Text('Error, please try again.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text(
                'Save and continue to dashboard',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
