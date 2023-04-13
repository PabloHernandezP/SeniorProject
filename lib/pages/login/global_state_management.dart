import 'package:get/get.dart';
import 'authentication.dart';

// not sure if should use variables or a class (might be minor difference)
// classes use different syntax so be wary
// class Controller extends GetxController {
//   var name = getAuthInstance().currentUser?.displayName.obs;
//   var email = getAuthInstance().currentUser?.email.obs;
//   var uid = getAuthInstance().currentUser?.uid.obs;
//   var signedThroughGoogle = false.obs; // used to determine which sign out to use
//
//   String? getUserInitials(){
//     return (name != null)
//         ? name!.trim()!.split(RegExp(' +')).map((s) => s[0]).take(2).join()
//         : '';
//   }
// }

var name = getAuthInstance().currentUser?.displayName.obs;
var email = getAuthInstance().currentUser?.email.obs;
var uid = getAuthInstance().currentUser?.uid.obs;
var signedThroughGoogle = false.obs; // used to determine which sign out to use

String? getUserInitials(){
  return (name != null)
      ? name!.trim()!.split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}