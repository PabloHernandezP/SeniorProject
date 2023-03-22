import 'package:equine_ai/main.dart';
import 'package:equine_ai/pages/dashboard/widgets/dashboard_body.dart';
import 'package:equine_ai/pages/dashboard/widgets/data_grid.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Dashboard",
        onDrawerPressed: () {},
        onSettingsPressed: () {},
      ),
      drawer: const MyDrawer(),
      body: const DataGrid(),
    );
  }
}
