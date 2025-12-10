import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  final int? airbnbBookings;
  final int? referralBookings;
  final int? bookingsDotComBookings;
  final int? directClients;
  final bool hasBorder;
  const CustomPieChart({
    super.key,
    this.airbnbBookings,
    this.referralBookings,
    this.bookingsDotComBookings,
    this.hasBorder = false,
    this.directClients,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: size.height * 0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              hasBorder
                  ? Border.all(width: 1, color: theme.primaryColor)
                  : null,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PieChart(
                duration: const Duration(microseconds: 300),
                PieChartData(
                  centerSpaceRadius: 10,
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue.shade900,
                      value: bookingsDotComBookings?.toDouble() ?? 1,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.redAccent,
                      value: airbnbBookings?.toDouble() ?? 1,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.deepPurple.shade400,
                      value: referralBookings?.toDouble() ?? 1,
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: directClients?.toDouble() ?? 1,
                      radius: 100,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: <Widget>[
                  SizedBox(height: 4),
                  indicator(color: Colors.redAccent, text: 'airbnb'),
                  SizedBox(height: 4),
                  indicator(
                    color: Colors.deepPurple.shade400,
                    text: 'referral',
                  ),
                  SizedBox(height: 4),
                  indicator(color: Colors.green, text: 'direct'),
                  indicator(color: Colors.blue.shade900, text: 'bookings.com'),
                  SizedBox(height: 4),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget indicator({
  required Color color,
  required String text,
  bool isSquare = false,
}) {
  return Column(
    spacing: 5,
    children: [
      Container(
        height: 20,
        width: 20,

        decoration: BoxDecoration(
          color: color,
          borderRadius: isSquare ? null : BorderRadius.circular(15),
        ),
      ),
      Text(text),
    ],
  );
}
