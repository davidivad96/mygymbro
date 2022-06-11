import 'package:flutter/material.dart';

import 'package:mygymbro/utils/localization.dart';

class Training extends StatelessWidget {
  const Training({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              getTranslated(context, "training"),
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
