import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/home/home_page_view_model.dart';
import 'package:rental_finance_tracker/features/home/presentation/widgets/recent_bookings.dart';
import 'package:rental_finance_tracker/features/home/presentation/widgets/stats_card.dart';
import 'package:rental_finance_tracker/global/graphs/line_graph.dart';
import 'package:rental_finance_tracker/global/graphs/pie_chart.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}



class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final state = ref.watch(homePageViewModelProvider);
    return Scaffold(
      body: Center(
        child:  state.error !=null ? Text('${state.error}')
              :  RefreshIndicator(
                onRefresh: () async {
                    await ref.read(homePageViewModelProvider.notifier).onRefresh();
                  },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                      spacing: 5,
                      children: [
                        TitleBar(
                          title: 'Good Afternoon, Jayder',
                          subtitle: 'SEPTEMBER STATISTICS',
                          icon: FontAwesomeIcons.userAstronaut,
                          customHeight: size.height * 0.17,
                          isAppBar: true,
                          newBorderRadius: 20,
                          gradientColors: [
                            lighten(theme.primaryColor, 0.2),
                            darken(theme.primaryColor, 0.2),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          height: size.height * 0.25,
                          width: double.infinity,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                StatsCard(
                  isLoading: state.isLoading,
                  mainIcon: FontAwesomeIcons.moneyBill1Wave,
                  title: 'Monthly Revenue',
                  total: state.monthToDateRevenue,
                ),
                StatsCard(
                  isLoading: state.isLoading,
                  addCurrency: false,
                  mainIcon: FontAwesomeIcons.bed,
                  title: 'Bookings',
                  total: state.monthToDateTotal ?? 00,
                ),
                StatsCard(
                  isLoading: state.isLoading,
                  addCurrency: false,
                  mainIcon: FontAwesomeIcons.calendarCheck,
                  title: 'Days Booked',
                  total: state.monthBookedDays,
                ),
                StatsCard(
                  isLoading: state.isLoading,
                  mainIcon: FontAwesomeIcons.chartLine,
                  title: 'Profit',
                  total: 36000,
                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12),
                child: Text(
                  'Income Trend',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                child: Text(
                  'Booking Sources',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                            ),
                            CustomPieChart(
                airbnbBookings: state.bookingsFromAirbnb,
                referralBookings: state.bookingsFromReferral,
                bookingsDotComBookings: state.bookingsFromBookingDotCom,
                directClients: state.directBookings,
                            ),
                          ],
                        ),
                        Container(
                          height: size.height *0.5,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: theme.primaryColor,
                    ),
                    Text(
                      'Recent Bookings',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: RecentBookings(
                      bookings: state.bookings,
                      isLoading: state.isLoading,
                  )
                )
                            ],
                          ),
                        ),
                      ],
                    ),
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
            child: Icon(Icons.king_bed, color: Colors.white),
            onTap: () => context.pushNamed('newBookings'),
          ),
          SpeedDialChild(
            backgroundColor: theme.primaryColor.withAlpha(200),
            child: Icon(Icons.request_page, color: Colors.white),
            onTap: () => context.pushNamed('newExpense'),
          ),
        ],
      ),
    );
  }
}
