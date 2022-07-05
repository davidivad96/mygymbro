import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:mygymbro/widgets/big_text.dart';

class StartWorkoutScreen extends StatefulWidget {
  final String workoutName;

  const StartWorkoutScreen({Key? key, required this.workoutName})
      : super(key: key);

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            BigText(text: widget.workoutName),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime = StopWatchTimer.getDisplayTime(
                  value,
                  hours: false,
                  minute: true,
                  second: true,
                  milliSecond: false,
                );
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => {},
          ),
        ],
      ),
      body: const Text("Start workout screen"),
    );
  }
}
