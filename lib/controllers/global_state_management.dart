import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../pages/login/authentication.dart';
import '../pages/profile/widgets/equine_profile.dart';

class AuthController extends GetxController {

  RxBool loggedIn = false.obs;
  var name = getAuthInstance().currentUser?.displayName.obs;
  var email = getAuthInstance().currentUser?.email.obs;
  var uid = getAuthInstance().currentUser?.uid.obs;
  var signedThroughGoogle = false.obs; // used to determine which sign out to use
  var equineProfileNames = <String>{}.obs;
  final equineProfiles = <EquineProfile>[].obs;

  @override
  void onInit() {
    super.onInit();
    _subscribe();
  }

  void _subscribe() {
    getAuthInstance().authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn(false);
        // reset variables
        signedThroughGoogle = false.obs; // used to determine which sign out to use
        equineProfiles.clear();
        equineProfileNames.clear();
      } else {
        loggedIn(true);
      }
      // update variables upon change
      name = getAuthInstance().currentUser?.displayName.obs;
      email = getAuthInstance().currentUser?.email.obs;
      uid = getAuthInstance().currentUser?.uid.obs;
    });
  }
}

final databaseReference = FirebaseDatabase.instance.reference();

String? getUserInitials(){
  final authService = Get.find<AuthController>();

  return (authService.name?.value != null)
      ? authService.name!.value!.trim()!.split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}