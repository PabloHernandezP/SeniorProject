import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'success_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
    // scopes: [
    //   'email',
    //   'https://www.googleapis.com/auth/contacts.readonly',
    // ],
    );

String? name;
String? imageUrl;

bool? authSignedIn;
String? uid;
String? userEmail;

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

    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

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

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
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

    uid = user.uid;
    userEmail = user.email;

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

    uid = user.uid;
    userEmail = user.email;

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

  uid = null;
  userEmail = null;

  return 'User signed out';
}

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
            //Get.off(SuccessScreen());
            print(result);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => SuccessScreen(),
              ),
            );
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
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
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
