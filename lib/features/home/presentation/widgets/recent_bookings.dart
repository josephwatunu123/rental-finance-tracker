import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/global/widgets/no_items_widget.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

class RecentBookings extends StatefulWidget {
  final List<BookingModel>? bookings;
  final bool isLoading;
  const RecentBookings({
    super.key,
    required this.bookings,
    required this.isLoading,
  });

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return (widget.isLoading)
        ? Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppConstants.bookingsLoadingGif),
            ),
          ),
        )
        : (widget.bookings == null || widget.bookings!.isEmpty)
        ? NoItemsWidget()
        : Column(
          children: List.generate(
            widget.bookings?.length ?? 0,
            (index) => bookingsInfoCard(
              theme: theme,
              size: size,
              booking: widget.bookings?[index],
            ),
          ),
        );
  }

  Widget bookingsInfoCard({
    required ThemeData theme,
    required Size size,
    required BookingModel? booking,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: size.height * 0.11,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMain),
          border: Border.all(width: 0.7, color: theme.primaryColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        CupertinoIcons.person_fill,
                        color: theme.primaryColor,
                        size: 15,
                      ),
                      Text(
                        (booking?.name ?? "--"),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: size.height * 0.032,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusMain,
                          ),
                          border: Border.all(
                            width: 0.7,
                            color: theme.primaryColor,
                          ),
                        ),
                        child: Text(
                          (booking?.bookingSource ?? "--"),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.pin_drop_rounded,
                        color: theme.primaryColor,
                        size: 15,
                      ),
                      Text('City Oasis'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${formatDate(booking?.from) ?? "--"} '
                        '-'
                        ' ${formatDate(booking?.to) ?? "--"}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text('Kes.${(booking?.amountPaid) ?? "-1"}'),
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  height: size.height * 0.032,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadiusMain,
                    ),
                    color: Colors.green[500],
                  ),
                  child: Text(
                    (booking?.status) ?? '--',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
