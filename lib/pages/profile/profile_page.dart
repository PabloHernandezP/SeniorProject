import 'package:equine_ai/pages/profile/widgets/profile_page_body.dart';
import 'package:equine_ai/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Information"),
      ),
      drawer: const MyDrawer(),
      body: const ProfileBody(),
    );
  }
}
