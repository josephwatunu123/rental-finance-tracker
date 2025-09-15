import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/global/graphs/graph_lines_title.dart';

class LineGraph extends StatelessWidget {
  const LineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      height: size.height * 0.4,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          minX: 0,
          minY: 0,
          maxY: 6,
          maxX: 11,
          titlesData: LinesTitles.getTileData(),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value){
              return FlLine(
                color: Colors.blue,
                strokeWidth: 0.5
              );
            }
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0,3),
                FlSpot(2.6,2),
                FlSpot(4.9,5),
              ],
              isCurved: true,
              barWidth: 3
            )
          ]

        )
      ),
    );
  }
}
