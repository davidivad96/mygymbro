import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  final List<History> history;

  const HistoryScreen({Key? key, required this.history}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
            child: widget.history.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.history.length,
                    itemBuilder: (BuildContext context, int index) {
                      History history = widget.history[index];
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
