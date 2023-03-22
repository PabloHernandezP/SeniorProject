import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'login_screen.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  _SuccessScreen createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Success Page"),
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
            TextButton(
              onPressed: () async {
                await signOut()
                    .then((value) => Get.off(LoginScreen()))
                    .catchError((onError) => print("Log out unsuccessful")
                );
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