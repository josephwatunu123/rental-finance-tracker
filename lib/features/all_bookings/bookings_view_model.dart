import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';

import 'bookings_state.dart';

class BookingsPageViewModel extends StateNotifier<BookingsPageState>{
  final BookingRepository repository;

  BookingsPageViewModel({required this.repository}) : super(BookingsPageState());

  onStartDateChanged(DateTime? startDate) {
    debugPrint("reached start Date changer and got the date $startDate");
    state = state.copyWith(startDate: startDate,);
  }

  onEndDateChanged(DateTime? endDate) {
    debugPrint("reached start Date changer and got the date $endDate");
    state = state.copyWith(endDate: endDate,);
  }


}

final bookingsPageViewModelProvider = StateNotifierProvider<BookingsPageViewModel, BookingsPageState>((ref){
  final repository = ref.watch(bookingRepositoryProvider);
  return BookingsPageViewModel(repository: repository);

});