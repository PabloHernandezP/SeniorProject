import 'package:equine_ai/widgets/filter.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onDrawerPressed;
  final VoidCallback onSettingsPressed;

  const MyAppBar({
    Key? key,
    required this.title,
    required this.onDrawerPressed,
    required this.onSettingsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // titleSpacing: MediaQuery.of(context).size.width / 10,
      title: Text(title),
      actions: <Widget>[
        Filter(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
