import 'package:equine_ai/pages/profile/widgets/profile_page_body.dart';
import 'package:equine_ai/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/global_state_management.dart';

class ProfilePage extends StatelessWidget {

  final authService = Get.find<AuthController>();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profiles"),
      ),
      drawer: MyDrawer(),
      body: const ProfilePageBody(),
    );
  }
}
