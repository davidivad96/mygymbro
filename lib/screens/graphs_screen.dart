import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';

class GraphsScreen extends StatelessWidget {
  const GraphsScreen({Key? key}) : super(key: key);

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
              GraphsConstants.title,
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
                      Icons.fitness_center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const BigText(
                      text: GraphsConstants.noGraphsTitle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      GraphsConstants.noGraphsText,
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
