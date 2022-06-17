import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:mygymbro/constants.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            GraphsConstants.title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                SfSparkLineChart(
                  //Enable the trackball
                  trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap,
                  ),
                  //Enable marker
                  marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all,
                  ),
                  //Enable data label
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  data: const <double>[
                    1,
                    5,
                    -6,
                    0,
                    1,
                    -2,
                    7,
                    -7,
                    -4,
                    -10,
                    13,
                    -6,
                    7,
                    5,
                    11,
                    5,
                    3
                  ],
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Weight progress'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Weight',
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
