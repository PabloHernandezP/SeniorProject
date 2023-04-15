import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/history/history.dart';
import 'package:equine_ai/pages/login/display_name.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:equine_ai/pages/profile/profile_page_2.dart';
import 'package:equine_ai/pages/upload/upload_data_page.dart';
import 'package:get/get.dart';


appRoutes() => [
  GetPage(
    name: '/login',
    page: () => LoginScreen(),

    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/name',
    page: () => DisplayNameScreen(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfilePage(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/dashboard',
    page: () => Dashboard(),
    // middlewares: [MyMiddelware()],
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/history',
    page: () => History(),
    // middlewares: [MyMiddelware()],
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/upload',
    page: () => UploadDataPage(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),
  ),
];
