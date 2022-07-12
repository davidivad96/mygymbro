import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
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
            child: Center(
              child: SizedBox(
                width: Dimensions.centeredContentWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.history,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const BigText(text: HistoryConstants.noHistoryTitle),
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
