import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/chart_constants.dart';

class CustomPieChart extends StatelessWidget {
  final int? airbnbBookings;
  final int? referralBookings;
  final int? bookingsDotComBookings;
  final int? directClients;
  const CustomPieChart({
    super.key,
    this.airbnbBookings,
    this.referralBookings,
    this.bookingsDotComBookings,
    this.directClients});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PieChart(
              duration: const Duration(microseconds: 300),
              PieChartData(
                centerSpaceRadius: 20,
                sections: [
                  PieChartSectionData(
                    color: pieChartColor1,
                    value: bookingsDotComBookings?.toDouble() ?? 1,
                    radius: 100,
                  ),
                  PieChartSectionData(
                    color: pieChartColor2,
                    value: airbnbBookings?.toDouble() ?? 1,
                    radius: 100,
                  ),
                  PieChartSectionData(
                    color: pieChartColor3,
                    value: referralBookings?.toDouble() ?? 1,
                    radius: 100,
                  ),
                  PieChartSectionData(
                    color: pieChartColor4,
                    value: directClients?.toDouble() ?? 1,
                    radius: 100,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
            width: double.infinity,
            child: Row(
              spacing: 15,
              children: <Widget>[
                indicator(
                  color: pieChartColor1,
                  text: 'bookings.com',
                  isSquare: true,
                ),
                SizedBox(height: 4),
                indicator(
                  color: pieChartColor2,
                  text: 'airbnb',
                  isSquare: true,
                ),
                SizedBox(height: 4),
                indicator(
                  color: pieChartColor3,
                  text: 'referral',
                  isSquare: true,
                ),
                SizedBox(height: 4),
                indicator(
                  color: pieChartColor4,
                  text: 'direct',
                  isSquare: true,
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget indicator({
  required Color color,
  required String text,
  required bool isSquare,
}) {
  return Column(
    spacing: 5,
    children: [Container(height: 20, width: 20, color: color), Text(text)],
  );
}
