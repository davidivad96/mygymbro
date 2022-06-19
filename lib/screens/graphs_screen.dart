import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/utils/dimensions.dart';

class GraphsScreen extends StatelessWidget {
  const GraphsScreen({Key? key}) : super(key: key);

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
                      Icons.show_chart,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      GraphsConstants.noGraphsTitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
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
