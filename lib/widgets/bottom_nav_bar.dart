import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      hasNotch: true,
      opacity: 1,
      currentIndex: _currentIndex,
      onTap: _changePage,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      elevation: 8,
      tilesPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      backgroundColor: Theme.of(context).highlightColor,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.fitness_center,
            color: Theme.of(context).primaryColor,
          ),
          activeIcon: Icon(
            Icons.fitness_center,
            color: Theme.of(context).highlightColor,
          ),
          title: Text(
            "Train",
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.show_chart,
            color: Theme.of(context).primaryColor,
          ),
          activeIcon: Icon(
            Icons.show_chart,
            color: Theme.of(context).highlightColor,
          ),
          title: Text("Graphs",
              style: TextStyle(color: Theme.of(context).highlightColor)),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).primaryColor,
          ),
          activeIcon: Icon(
            Icons.settings,
            color: Theme.of(context).highlightColor,
          ),
          title: Text(
            "Settings",
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        )
      ],
    );
  }
}
