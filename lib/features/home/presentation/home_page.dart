import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/home/presentation/widgets/recent_bookings.dart';
import 'package:rental_finance_tracker/features/home/presentation/widgets/stats_card.dart';
import 'package:rental_finance_tracker/global/graphs/line_graph.dart';
import 'package:rental_finance_tracker/global/graphs/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Dashboard',style:theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,color: Colors.white) ,),
        centerTitle: false,
        actions: [
          Icon(CupertinoIcons.bell_fill),
          const SizedBox(width: 15),
          IconButton(
            onPressed: ()=>context.pushNamed('settings'),
            icon:Icon(CupertinoIcons.person_alt_circle_fill,)
            ,),
        ],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 5,
          children: [
            userGreetings(theme: theme),
            Container(
              padding: EdgeInsets.all(12),
              height: size.height * 0.25,
              width: double.infinity,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children:[
                  StatsCard(
                      mainIcon: FontAwesomeIcons.moneyBill1Wave,
                      title: 'Monthly Revenue',
                      total: 60000
                  ),
                  StatsCard(
                      mainIcon: FontAwesomeIcons.bed,
                      title: 'Bookings',
                      total: 11
                  ),
                  StatsCard(
                      mainIcon: FontAwesomeIcons.calendarCheck,
                      title: 'Days Booked',
                      total: 24
                  ),
                  StatsCard(
                      mainIcon: FontAwesomeIcons.chartLine,
                      title: 'Profit',
                      total: 36000
                  ),
                ],
              )
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 12),
                  child: Text('Income Trend',style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),),
                ),
                LineGraph(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Booking Sources',style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),),
                ),
                CustomPieChart(),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Icon(Icons.calendar_today_rounded,color: theme.primaryColor,),
                      Text('Recent Bookings',style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  RecentBookings(),
                  RecentBookings(),
                  RecentBookings(),
                  RecentBookings(),
                  RecentBookings()
                ],

              ),
            ),
          ],
        ),
      ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          overlayOpacity: 0.8,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              backgroundColor: theme.primaryColor,
              child: Icon(Icons.king_bed,color: Colors.white,),
              onTap: ()=>context.pushNamed('newBookings')
            ),
            SpeedDialChild(
                backgroundColor: theme.primaryColor.withAlpha(200),
                child: Icon(Icons.request_page,color: Colors.white,),
                onTap: ()=>context.pushNamed('newExpense')
            ),
          ],
        )
    );
  }
  
  Widget userGreetings(
  {
    required ThemeData theme,
}
      ){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Text(
            "Good Evening, Jayder. Today's Overview",
            style: theme.textTheme.bodySmall,),
          Text(
              "10th September 2025",
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
