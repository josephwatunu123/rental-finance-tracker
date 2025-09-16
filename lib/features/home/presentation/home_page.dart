import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/home/presentation/widgets/recent_bookings.dart';
import 'package:rental_finance_tracker/global/graphs/line_graph.dart';
import 'package:rental_finance_tracker/global/graphs/pie_chart.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              userGreetings(theme: theme),
              SizedBox(
                height: size.height * 0.25,
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(4, (index){
                    return statsContainer(
                        height: size.height * 0.1,
                        width: size.width * 0.45,
                        theme: theme
                    );
                  }),
                )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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

  Widget statsContainer({
    required double height,
    required double width,
    required ThemeData theme
}){
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.5,
          color: Colors.grey
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Revenue',style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kes. 60,000',style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              Icon(Icons.payments_rounded,
                color: Colors.blueAccent
                ,)
            ],
          ),
          Text('+12%',style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,color: Colors.green))
        ],
      ),
    );
  }
}
