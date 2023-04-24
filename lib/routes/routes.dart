import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/history/history.dart';
import 'package:equine_ai/pages/login/display_name.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:equine_ai/pages/upload/upload_data_page.dart';
import 'package:equine_ai/pages/profile/profile_page.dart';
import 'package:equine_ai/routes/middlewares.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/name',
        page: () => const DisplayNameScreen(),
        middlewares: [LoginGuard()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        middlewares: [LoginGuard()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/dashboard',
        page: () => const Dashboard(),
        middlewares: [LoginGuard()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/history',
        page: () => const History(),
        middlewares: [LoginGuard()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/upload',
        page: () => const UploadDataPage(),
        middlewares: [LoginGuard()],
        // transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
    ];
