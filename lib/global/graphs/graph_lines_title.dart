import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class LinesTitles {
  static const List<String> months =[
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D'
  ];

  static getTileData ()=> FlTitlesData(
    show:  true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta){
          int index = value.toInt();
          if(index >=0 && index< months.length){
            return Text(months[index]);
          }
          return Text('');

        }
      )
    ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 10,
      ),
    ),

  );
}