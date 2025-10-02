import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

class RecentBookings extends StatefulWidget {
  final BookingModel? bookings;
  const RecentBookings({super.key, required this.bookings});

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height * 0.11,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMain),
        border: Border.all(width: 0.08, color: CupertinoColors.black),
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
                    Icon(CupertinoIcons.person, color: Colors.black, size: 15),
                    Text(
                      (widget.bookings?.name ?? "--"),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: size.height * 0.032,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMain),
                        border: Border.all(width: 0.08, color: Colors.black),
                      ),
                      child: Text(
                        (widget.bookings?.bookingSource ?? "--" ),
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
                      Icons.pin_drop_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                    Text('City Oasis'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('${formatDate(widget.bookings?.from) ?? "--"} ' '-' ' ${formatDate(widget.bookings?.to) ?? "--"}')],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text('Kes.${(widget.bookings?.amountPaid) ?? "-1"}'),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: size.height * 0.032,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMain),
                  color: Colors.green[500],
                ),
                child: Text(
                  (widget.bookings?.status) ?? 'pending',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
