import 'package:equine_ai/pages/dashboard/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_drawer.dart';
import '../../controllers/global_state_management.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Latest Results",
        onDrawerPressed: () {},
        onSettingsPressed: () {},
      ),
      drawer: MyDrawer(),
      body: const DashboardBody(),
    );
  }
}
