import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
    // scopes: [
    //   'email',
    //   'https://www.googleapis.com/auth/contacts.readonly',
    // ],
    );


String? _imageUrl;
String? _name;
bool? _authSignedIn;
String? _uid;
String? _userEmail;

FirebaseAuth getAuthInstance() {
  return _auth;
}

bool validateEmail(String? value) {
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

bool validatePassword(String? value) {
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

Future<String?> signInWithGoogle() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication?.accessToken,
    idToken: googleSignInAuthentication?.idToken,
  );

  final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  if (user != null) {
    // Checking if email and name is null
    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    _uid = user.uid;
    _name = user.displayName;
    _userEmail = user.email;
    _imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);



    return 'Google sign in successful, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  _uid = null;
  _name = null;
  _userEmail = null;
  _imageUrl = null;

  return "User signed out of Google account";
}

Future<String> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    _uid = user.uid;
    _userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    return 'Successfully registered, User UID: ${user.uid}';
  }

  return 'Registration unsuccessful';
}

Future<String> signInWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    _uid = user.uid;
    _userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return 'Log in unsuccessful';
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  _uid = null;
  _userEmail = null;

  return 'User signed out';
}

Future<String> forgotPassword(String? email) async {


  if (email == null){
    return "Please enter an email.";
  } // Google users need to reset through google. Cannot sort through users that use gmail under proprietary domain
  else if (email.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail.com"))){
    return "Please reset password through Google.";
  }
  else if (!validateEmail(email) ){
    return "Invalid email. Please try again";
  }
  else {
    await _auth.sendPasswordResetEmail(email: email);
  }
  return 'Reset password link sent!';
}


class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;
  //final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        //highlightColor: Colors.blueGrey[100],
        //splashColor: Colors.blueGrey[200],
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInWithGoogle().then((result) {
            //Get.off(const Dashboard());
            //Get.off(()=>Dashboard());
            Get.toNamed("/dashboard");
            signedThroughGoogle.value = true; // for calling correct log out implementation
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   side: BorderSide(color: Colors.blueGrey, width: 3),
        // ),
        // highlightElevation: 0,
        // borderSide: BorderSide(color: Colors.blueGrey, width: 3),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
