import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/graph.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';

class GraphsScreen extends StatefulWidget {
  final List<Graph> graphs;

  const GraphsScreen({Key? key, required this.graphs}) : super(key: key);

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Graph> graphs =
        widget.graphs.where((graph) => graph.data.length > 1).toList();
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
            child: graphs.isNotEmpty
                ? ListView.builder(
                    itemCount: graphs.length,
                    itemBuilder: (context, index) {
                      final graph = graphs[index];
                      return SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          rangePadding: ChartRangePadding.round,
                          dateFormat: DateFormat.MMMd(),
                        ),
                        primaryYAxis: NumericAxis(
                          labelFormat: '{value}kgs',
                        ),
                        title: ChartTitle(
                          text: graph.exercise.name,
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        series: <ChartSeries>[
                          // Renders spline chart
                          LineSeries<Data, DateTime>(
                            dataSource: graph.data,
                            xValueMapper: (Data data, _) => data.x,
                            yValueMapper: (Data data, _) => data.y,
                          )
                        ],
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
