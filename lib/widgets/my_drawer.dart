import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:equine_ai/pages/login/global_state_management.dart';
import 'package:equine_ai/pages/upload/upload_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/login/authentication.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Controller c = Get.find();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Obx(() => Text("${name!.value}")),
            accountEmail: Obx(() => Text("${email!.value}")),
            currentAccountPicture: CircleAvatar(
              child: Text(getUserInitials()!),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Get.to(const Dashboard());
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_upload),
            title: const Text('Upload Data'),
            onTap: () {
              Navigator.pop(context);
              Get.to(const UploadDataPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              // Navigate to the history page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              if (signedThroughGoogle.isTrue){ // use google sign out method
                await signOutGoogle().then((r){
                  signedThroughGoogle.value = false; // reset back to false after sign out
                  Get.off(LoginScreen());
                });
              }
              else { // use normal sign out method
                await signOut().then((r){
                    Get.off(LoginScreen());
                  });
              }
            },
          ),
        ],
      ),
    );
  }
}
