import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';

class FirebaseBookingImplementation implements BookingRepository {
  final FirebaseFirestore firestore;

  FirebaseBookingImplementation(this.firestore);

  //TODO: Consider implementing snack bars to show us what is the error
  @override
  Future<List<BookingModel>?> getBookings({
    required DateTime startDate,
    required DateTime endDate,
    String? searchName,
  }) async {
    try {
      final snapshot =
          await firestore
              .collection('bookings')
              .where('from', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
              .where(
                'to',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
              )
              .get();
      log(
        'response firebase::: '
        'Found ${snapshot.docs.length} bookings. '
        'queryParams: {$startDate,$endDate }'
        'Document IDs: ${snapshot.docs.map((doc) => doc.id).toList()}. '
        'Data: ${snapshot.docs.map((doc) => doc.data()).toList()}',
      );
      return snapshot.docs.map((booking) {
        return BookingModel.fromJson(booking.data());
      }).toList();
    } catch (e, st) {
      log("error fetching bookings::: $e, $st");
      SnackBarService.show(
        message: '$e',
        title: 'An Error Occurred',
        snackBarType: SnackBarType.error,
      );
      return null;
    }
  }

  @override
  Future<Map<bool, String>> addBooking(BookingModel booking) async {
    log("Booking to be submitted::: ${booking.toString()}");
    try {
      await firestore.collection('bookings').add(booking.toJson());
      return {true: 'Successfully Created Booking.'};
    } catch (e, st) {
      log("error fetching bookings::: $e, $st");
      SnackBarService.show(
        message: '$e',
        title: 'An Error Occurred',
        snackBarType: SnackBarType.error,
      );
      return {false: 'Error: $e'};
    }
  }

  @override
  Future<double?> getTotalBookingsFromSource({
    required String source,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = firestore
          .collection('bookings')
          .where('bookingSource', isEqualTo: source);
      if (endDate != null) {
        query = query.where(
          'from',
          isLessThanOrEqualTo: Timestamp.fromDate(endDate),
        );
      }
      if (startDate != null) {
        query = query.where(
          'to',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
        );
      }
      final snapshot = await query.get();
      log(
        'response firebase::: '
        'Found ${snapshot.docs.length} number of bookings from $source.\n '
        'queryParams: {$source}\n'
        'Document IDs: ${snapshot.docs.map((doc) => doc.id).toList()}. \n'
        'Data: ${snapshot.docs.map((doc) => doc.data()).toList()}',
      );
      return snapshot.docs.length.toDouble();
    } catch (e, st) {
      log("error fetching airbnb bookings total::: $e, $st");
      return null;
    }
  }

  @override
  Future<List<DateTime>> getBookedDaysOnSelectedMonth({
    required DateTime selectedMonth,
  }) async{
    final startOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final endOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    final snapshot = await firestore
        .collection('bookings')
        .where('from', isLessThanOrEqualTo: endOfMonth)
        .where('to', isGreaterThanOrEqualTo: startOfMonth)
        .get();
    log('response firebase:: '
        'Number of booked days found ${snapshot.docs.length}'
        'Query params: {$selectedMonth}'
        'Data: ${snapshot.docs.map((doc) => doc.data()).toList()}'
    );
    final List<DateTime> bookedDays = [];
    for(var doc in snapshot.docs){
      final data = doc.data();
      final from = (data['from'] as Timestamp).toDate();
      final to = (data['to'] as Timestamp).toDate();
      DateTime current = from;
      while (current.isBefore(to)) {
        bookedDays.add(DateTime(current.year, current.month, current.day));
        current = current.add(const Duration(days: 1));
      }
    }

    return bookedDays;
    }

  }

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return FirebaseBookingImplementation(FirebaseFirestore.instance);
});
