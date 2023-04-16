import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginGuard extends GetMiddleware {
  final authService = Get.find<AuthController>();

  // TODO: CHECK THE ORDER THAT LOGIN STATUS IS CHANGED/ THIS FUNCTION CALLED
  // should be fine because validate first (thus signing in) and then call route function

  @override
  RouteSettings? redirect(String? route) {
    return authService.loggedIn.value
        ? null // continue as normal
        : const RouteSettings(name: "/login"); // if not, block and force back to login
  }
}