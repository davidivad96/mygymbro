import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:mygymbro/constants.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int?) changePage;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.changePage,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      hasNotch: true,
      opacity: 1,
      currentIndex: widget.currentIndex,
      onTap: widget.changePage,
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
            WorkoutsConstants.title,
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.history,
            color: Theme.of(context).primaryColor,
          ),
          activeIcon: Icon(
            Icons.history,
            color: Theme.of(context).highlightColor,
          ),
          title: Text(
            HistoryConstants.title,
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.list,
            color: Theme.of(context).primaryColor,
          ),
          activeIcon: Icon(
            Icons.list,
            color: Theme.of(context).highlightColor,
          ),
          title: Text(
            ExercisesConstants.title,
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
          title: Text(
            GraphsConstants.title,
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
      ],
    );
  }
}
