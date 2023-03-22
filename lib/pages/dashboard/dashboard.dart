import 'package:flutter/material.dart';
import 'package:equine_ai/pages/dashboard/widgets/data_grid.dart';
import '../../widgets/my_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      drawer: const MyDrawer(),
      body: const DataGrid(),
    );
  }
}
