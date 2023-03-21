import 'package:equine_ai/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authentication.dart';

TextEditingController? textControllerEmail;
FocusNode? textFocusNodeEmail;
bool _isEditingEmail = true;

TextEditingController? textControllerPassword;
FocusNode? textFocusNodePassword;
bool _isEditingPassword = true;

bool _isRegistering = false;

bool _validateEmail(String? value) {
  value = value?.trim();

  if (textControllerEmail?.text != null) {
    if (value != null) {
      if (value.isEmpty) {
        return false;
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return false;
      }
    } else {
      return false;
    }
  }

  return true;
}

bool _validatePassword(String? value) {
  value = value?.trim();

  if (textControllerPassword?.text != null) {
    if (value != null) {
      if (value.isEmpty) {
        return false;
      } else if (!value.contains(
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]{6,}"))) {
        return false;
      }
    } else {
      return false;
    }
  }

  return true;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
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
      appBar: AppBar(
        title: const Text("Login Page"),
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
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800]!,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: "Email",
                  fillColor: Colors.white,
                  errorText: _validateEmail(textControllerEmail?.text)
                      ? null
                      : "Invalid email",
                  errorStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            Padding(
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
                onSubmitted: (value) {
                  textFocusNodePassword?.unfocus();
                  //FocusScope.of(context).requestFocus(textFocusNodePassword);
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800]!,
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: "Password",
                  fillColor: Colors.white,
                  errorText: _validatePassword(textControllerPassword?.text)
                      ? null
                      : "Invalid password",
                  errorStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 12, bottom: 0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    _isRegistering = true;
                  });
                  if (_validateEmail(textControllerEmail?.text) &&
                      _validatePassword(textControllerPassword?.text)) {
                    await signInWithEmailPassword(textControllerEmail!.text,
                            textControllerPassword!.text)
                        .then((result) {
                      //print(result);
                      Get.off(const SuccessScreen());
                    }).catchError((error) {
                      print('Sign in Error: $error');
                    });
                    // setState(() {
                    //   _isRegistering = false;
                    //   _isEditingEmail = false;
                    // });
                  } else {
                    print("Sign in error");
                  }
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 12, bottom: 0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if (_validateEmail(textControllerEmail?.text) &&
                      _validatePassword(textControllerPassword?.text)) {
                    setState(() {
                      _isRegistering = true;
                    });
                    await registerWithEmailPassword(textControllerEmail!.text,
                            textControllerPassword!.text)
                        .then((result) {
                      //print(result);
                      const snackBar = SnackBar(
                        content:
                            Text('Registration successful! Please sign in.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }).catchError((error) {
                      print('Registration Error: $error');
                      const snackBar = SnackBar(
                        content: Text(
                            "This email address is already in use by another account."),
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
            Container(
              child: GoogleButton(),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
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
