import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/history/history.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:equine_ai/controllers/global_state_management.dart';
import 'package:equine_ai/pages/profile/profile_page.dart';
import 'package:equine_ai/pages/upload/upload_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/login/authentication.dart';

class MyDrawer extends StatelessWidget {

  final authService = Get.find<AuthController>();

  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Controller c = Get.find();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Obx(() => Text("${authService.name!.value}")),
            accountEmail: Obx(() => Text("${authService.email!.value}")),
            currentAccountPicture: CircleAvatar(
              child: Text(getUserInitials()!),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Manage Profiles'),
            onTap: () {
              Navigator.pop(context);
              //Get.to(const ProfilePage());
              Get.toNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_upload),
            title: const Text('Upload Data'),
            onTap: () {
              Navigator.pop(context);
              //Get.to(const UploadDataPage());
              Get.toNamed('/upload');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Analyze Data'),
            onTap: () {
              Navigator.pop(context);
              // Get.to(const Dashboard());
              Get.toNamed('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Access History'),
            onTap: () {
              Navigator.pop(context);
              //Get.to(const History());
              Get.toNamed('/history');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              if (authService.signedThroughGoogle.value) {
                // use google sign out method
                await signOutGoogle().then((r) {
                  //signedThroughGoogle.value = false; // reset back to false after sign out
                  authService.signedThroughGoogle(false); // reset back to false after sign out
                  //Get.off(LoginScreen());
                  Get.offAllNamed('/login');
                });
              } else {
                // use normal sign out method
                await signOut().then((r) {
                  //Get.off(LoginScreen());
                  Get.offAllNamed('/login');
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
