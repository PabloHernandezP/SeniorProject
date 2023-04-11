import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/profile/profile_page.dart';
import 'package:equine_ai/pages/upload/upload_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('johndoe@example.com'),
            currentAccountPicture: CircleAvatar(
              child: Text('JD'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
                Get.to(const ProfilePage());

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
            leading: const Icon(Icons.bar_chart),
            title: const Text('Analyze Data'),
            onTap: () {
              Navigator.pop(context);
              Get.to(const Dashboard());
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
            onTap: () {
              Navigator.pop(context);
              // Navigate to logout page
            },
          ),
        ],
      ),
    );
  }
}
