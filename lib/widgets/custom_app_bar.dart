import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/screens/profile_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        GeneralConstants.appName,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const ProfileScreen(),
                isScrollControlled: true,
              );
            },
            child: Image.asset(
              "assets/images/default_avatar.jpeg",
            ),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      elevation: 2.0,
    );
  }
}
