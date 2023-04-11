import 'package:equine_ai/pages/dashboard/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analyze Results"),
      ),
      drawer: const MyDrawer(),
      body: const DashboardBody(),
    );
  }
}
