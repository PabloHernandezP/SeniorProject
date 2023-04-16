import 'package:equine_ai/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../widgets/my_app_bar.dart';
import '../dashboard/dashboard.dart';
import 'authentication.dart';
import 'display_name.dart';
import '../../controllers/global_state_management.dart';

TextEditingController? textControllerEmail;
FocusNode? textFocusNodeEmail;
bool _isEditingEmail = true;

TextEditingController? textControllerPassword;
FocusNode? textFocusNodePassword;
bool _isEditingPassword = true;

bool _isRegistering = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  //final Controller c = Get.put(Controller());

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textFocusNodeEmail = FocusNode();

    textControllerPassword = TextEditingController();
    textFocusNodePassword = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
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
            Container(
              constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 200),
              child: TextField(
                focusNode: textFocusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: textControllerEmail,
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    _isEditingEmail = true;
                  });
                },
                onSubmitted: (value) {
                  textFocusNodeEmail?.unfocus();
                  FocusScope.of(context).requestFocus(textFocusNodePassword);
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800]!,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: "Email",
                  fillColor: Colors.white,
                  // errorText: _validateEmail(textControllerEmail?.text)
                  //     ? null
                  //     : "Invalid email",
                  // errorStyle: TextStyle(
                  //   fontSize: 12,
                  //   color: Colors.redAccent,
                  // ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                focusNode: textFocusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                //TODO: MIGHT NEED TO CHANGE, CHECK ON PHONE SIMULATOR
                textInputAction: TextInputAction.next,
                controller: textControllerPassword,
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    _isEditingPassword = true;
                  });
                },
                onSubmitted: (value) async {
                  textFocusNodePassword?.unfocus();
                  //FocusScope.of(context).requestFocus(textFocusNodePassword);

                  setState(() {
                    _isRegistering = true;
                  });
                  if (validateEmail(textControllerEmail?.text) &&
                      validatePassword(textControllerPassword?.text)) {
                    await signInWithEmailPassword(textControllerEmail!.text,
                        textControllerPassword!.text)
                        .then((result) {
                      Get.toNamed("/dashboard");
                    }).catchError((error) {
                      print('Sign in Error: $error');
                      var snackBar = SnackBar(
                        content: Text('Sign in Error: $error'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  } else {
                    print("Sign in error");
                    const snackBar = SnackBar(
                      content: Text("Sign in error."),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800]!,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: "Password",
                  fillColor: Colors.white,
                  // errorText: _validatePassword(textControllerPassword?.text)
                  //     ? null
                  //     : "Invalid password",
                  // errorStyle: TextStyle(
                  //   fontSize: 12,
                  //   color: Colors.redAccent,
                  // ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 12, bottom: 0),
              //padding: EdgeInsets.all(50.0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    _isRegistering = true;
                  });
                  if (validateEmail(textControllerEmail?.text) &&
                      validatePassword(textControllerPassword?.text)) {
                    await signInWithEmailPassword(textControllerEmail!.text,
                            textControllerPassword!.text)
                        .then((result) {
                      //print(result);
                      //Get.off(const Dashboard());
                      // Get.off(()=>'/dashboard');
                      Get.toNamed("/dashboard");
                    }).catchError((error) {
                      print('Sign in Error: $error');
                      var snackBar = SnackBar(
                        content: Text('Sign in Error: $error'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    // setState(() {
                    //   _isRegistering = false;
                    //   _isEditingEmail = false;
                    // });
                  } else {
                    print("Sign in error");
                    const snackBar = SnackBar(
                      content: Text("Sign in error."),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 12, bottom: 0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if (validateEmail(textControllerEmail?.text) &&
                      validatePassword(textControllerPassword?.text)) {
                    setState(() {
                      _isRegistering = true;
                    });
                    await registerWithEmailPassword(textControllerEmail!.text,
                            textControllerPassword!.text)
                        .then((result) {
                      //print(result);
                      const snackBar = SnackBar(
                        content: Text('Registration successful!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Get.off(DisplayNameScreen());
                      Get.offNamed('/name');
                    }).catchError((error) {
                      print('Registration Error: $error');
                      var snackBar = SnackBar(
                        content: Text('Registration Error: $error'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  } else {
                    print("Registration error");
                  }
                  setState(() {
                    _isRegistering = false;
                    _isEditingEmail = false;
                  });
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                ),
              child: GoogleButton(),
            ),
            TextButton(
              onPressed: () async {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
                await forgotPassword(textControllerEmail?.text).then((value) {
                  var snackBar = SnackBar(
                    content: Text(value),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }).catchError((error) {
                  print('Password reset error: $error');
                  var snackBar = SnackBar(
                    content: Text('Password reset error: $error'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
