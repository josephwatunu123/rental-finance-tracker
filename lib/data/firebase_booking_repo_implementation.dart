import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/booking_repository.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class FirebaseBookingImplementation implements BookingRepository{

  final FirebaseFirestore firestore;

  FirebaseBookingImplementation(this.firestore);

//TODO: Consider implementing snack bars to show us what is the error
  @override
  Future<List<BookingModel>?> getBookings({
    required DateTime startDate,
    required DateTime endDate
}) async{
    try{
      final snapshot = await firestore
          .collection('bookings')
          .where('from', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .where('to', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate)).get();
      log('response firebase::: '
          'Found ${snapshot.docs.length} bookings. '
            'queryParams: {${startDate},${endDate} }'
          'Document IDs: ${snapshot.docs.map((doc) => doc.id).toList()}. '
          'Data: ${snapshot.docs.map((doc) => doc.data()).toList()}');
      return snapshot.docs.map((booking){
        return BookingModel.fromJson(booking.data());
      }).toList();
    }catch( e, st){
      log("error fetching bookings::: $e, $st");
      return null;
    }
  }

  //TODO: Implement it using try catch


  @override
  Future<void> addBooking(BookingModel booking) async{
    await firestore.collection('bookings').add(booking.toJson());
  }

  @override
  Future<double?> getTotalBookingsFromSource({
    required String source,
    DateTime? startDate,
    DateTime? endDate
  }) async{
    try{
      var query = firestore.collection('bookings')
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
      log('response firebase::: '
          'Found ${snapshot.docs.length} number of bookings from $source.\n '
          'queryParams: {$source}\n'
          'Document IDs: ${snapshot.docs.map((doc) => doc.id).toList()}. \n'
          'Data: ${snapshot.docs.map((doc) => doc.data()).toList()}');
      return snapshot.docs.length.toDouble();
    }catch (e, st){
      log("error fetching airbnb bookings total::: $e, $st");
      return null;
    }
  }



}


final bookingRepositoryProvider = Provider<BookingRepository>((ref){
  return FirebaseBookingImplementation(FirebaseFirestore.instance);
});
