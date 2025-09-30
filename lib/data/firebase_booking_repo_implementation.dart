import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/booking_repository.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class FirebaseBookingImplementation implements BookingRepository{

  final FirebaseFirestore firestore;

  FirebaseBookingImplementation(this.firestore);


  @override
  Future<List<BookingModel>> getBookings() async{
    final snapshot = await firestore.collection('bookings').get();
    log("response firebase::: $snapshot");
    return snapshot.docs.map((booking){
      return BookingModel.fromJson(booking.data());
    }).toList();
  }


}


final bookingRepositoryProvider = Provider<BookingRepository>((ref){
  return FirebaseBookingImplementation(FirebaseFirestore.instance);
});
