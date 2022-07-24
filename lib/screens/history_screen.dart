import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/utils/functions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("histories");
  List<History> _histories = [];

  _initHistories() async {
    setState(() {
      _isLoading = true;
    });
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final histories = snapshot.children;
      setState(() {
        _histories = histories
            .map(
              (snapshot) => History.fromJson(transformSnapshot(snapshot.value)),
            )
            .toList();
      });
    }
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => setState(() {
        _isLoading = false;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _initHistories();
  }

  @override
  void dispose() {
    _dbRef.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.screenTitleMarginBottom),
            child: const Text(
              HistoryConstants.title,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  )
                : _histories.isNotEmpty
                    ? ListView.builder(
                        itemCount: _histories.length,
                        itemBuilder: (BuildContext context, int index) {
                          History history = _histories[index];
                          return Container(
                            key: Key(history.id),
                            constraints: BoxConstraints(
                              minHeight: Dimensions.cardMinHeight,
                            ),
                            child: HistoryCard(
                              history: history,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: SizedBox(
                          width: Dimensions.centeredContentWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.fitness_center,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const BigText(
                                text: HistoryConstants.noHistoryTitle,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                HistoryConstants.noHistoryText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
