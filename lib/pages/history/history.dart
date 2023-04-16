import 'package:equine_ai/pages/history/widgets/history_list.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_drawer.dart';
import '../../widgets/my_app_bar.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Previous Analysis",
        onDrawerPressed: () {},
        onSettingsPressed: () {},
      ),
      drawer: MyDrawer(),
      body: HistoryList(),
    );
  }
}
