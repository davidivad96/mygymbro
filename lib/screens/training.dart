import 'package:flutter/material.dart';

import 'package:mygymbro/utils/localization.dart';

class Training extends StatelessWidget {
  const Training({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            getTranslated(context, 'training'),
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              scrollDirection: Axis.vertical,
              children: [
                const Card(
                  color: Color(0xFFFF0000),
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                ),
                Card(
                  color: const Color(0xFFF5F5F5),
                  child: Image.network(
                    'https://picsum.photos/seed/229/600',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Card(
                  color: const Color(0xFFF5F5F5),
                  child: Image.network(
                    'https://picsum.photos/seed/229/600',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Card(
                  color: const Color(0xFFF5F5F5),
                  child: Image.network(
                    'https://picsum.photos/seed/229/600',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Card(
                  color: const Color(0xFFF5F5F5),
                  child: Image.network(
                    'https://picsum.photos/seed/229/600',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Card(
                  color: const Color(0xFFF5F5F5),
                  child: Image.network(
                    'https://picsum.photos/seed/229/600',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
