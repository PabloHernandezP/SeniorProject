import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../pages/login/authentication.dart';

// used for route guarding
class AuthController extends GetxController {

  RxBool loggedIn = false.obs;
  @override
  void onInit() {
    super.onInit();
    _subscribe();
  }

  void _subscribe() {
    getAuthInstance().authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn(false);
      } else {
        loggedIn(true);
      }
    });
  }
}

var name = getAuthInstance().currentUser?.displayName.obs;
var email = getAuthInstance().currentUser?.email.obs;
var uid = getAuthInstance().currentUser?.uid.obs;
var signedThroughGoogle = false.obs; // used to determine which sign out to use
var equineProfileNames = <String>{}.obs;

final databaseReference = FirebaseDatabase.instance.reference();

String? getUserInitials(){
  return (name != null)
      ? name!.trim()!.split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}

void resetState(){
  name = getAuthInstance().currentUser?.displayName.obs;
  email = getAuthInstance().currentUser?.email.obs;
  uid = getAuthInstance().currentUser?.uid.obs;
  signedThroughGoogle = false.obs; // used to determine which sign out to use
  equineProfileNames = <String>{}.obs;
}