import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

class BookingsList extends StatefulWidget {
  final List<BookingModel>? bookings;
  const BookingsList({super.key, required this.bookings});

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (widget.bookings == null || widget.bookings!.isEmpty)
        ? Container(
          alignment: Alignment.bottomCenter,
          height: size.height * 0.4,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.noItemsImage),
              fit: BoxFit.contain,
            ),
          ),
          child: const Text('No Bookings Found'),
        )
        : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 5,
            children: List.generate(widget.bookings!.length, (index) {
              return _bookingsCard(
                height: size.height * 0.1,
                width: double.infinity,
                name: widget.bookings?[index].name,
                apartmentName: 'City Oasis',
                amount: widget.bookings?[index].amountPaid,
                bookingSource: widget.bookings?[index].bookingSource,
                from: widget.bookings?[index].from,
                to: widget.bookings?[index].to,
              );
            }),
          ),
        );
  }

  Widget _bookingsCard({
    required double height,
    required double width,
    required String? name,
    required DateTime? from,
    required DateTime? to,
    required String? apartmentName,
    required double? amount,
    required String? bookingSource,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white60,
      ),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? 'Unknown'),
                Text(apartmentName ?? '--'),
                Text('${formatDate(from)} - ${formatDate(to)} '),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(amount.toString()), Text(bookingSource ?? '--')],
          ),
          Icon(CupertinoIcons.chevron_forward),
        ],
      ),
    );
  }
}
