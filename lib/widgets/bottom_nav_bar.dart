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
      backgroundColor: Colors.white,
      items: const <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Colors.blueAccent,
          icon: Icon(
            Icons.fitness_center,
            color: Colors.blueAccent,
          ),
          activeIcon: Icon(
            Icons.fitness_center,
            color: Colors.white,
          ),
          title: Text(
            "Train",
            style: TextStyle(color: Colors.white),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.blueAccent,
          icon: Icon(
            Icons.show_chart,
            color: Colors.blueAccent,
          ),
          activeIcon: Icon(
            Icons.show_chart,
            color: Colors.white,
          ),
          title: Text("Graphs", style: TextStyle(color: Colors.white)),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.blueAccent,
          icon: Icon(
            Icons.settings,
            color: Colors.blueAccent,
          ),
          activeIcon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          title: Text("Settings", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
