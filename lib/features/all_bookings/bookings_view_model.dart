import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';

import 'bookings_state.dart';

class BookingsPageViewModel extends StateNotifier<BookingsPageState>{
  final BookingRepository repository;

  BookingsPageViewModel({required this.repository}) : super(BookingsPageState()){
    init();
  }

  DateTime initialDate =AppConstants.firstDayOfCurrentMonth;
  DateTime endDate = AppConstants.today;
  String? searchName;

  Future<void> init()async{
    debugPrint('init called');
    state= state.copyWith(
      isLoading: true,
      startDate: initialDate,
      endDate: endDate,
    );
    final bookings= await repository.getBookings(
        startDate: initialDate ,
        endDate: endDate,
        searchName: searchName,
    );
    debugPrint('init called value received: $bookings');

    if(bookings !=null){
      state= state.copyWith(
        bookings: bookings,
      );
    }

    debugPrint('State holding after null check ${state.bookings}');
    state= state.copyWith(
      isLoading: false
    );
  }

  onStartDateChanged(DateTime? startDate) {
    debugPrint("reached start Date changer and got the date $startDate");
    state = state.copyWith(startDate: startDate,);
  }

  onEndDateChanged(DateTime? endDate) {
    debugPrint("reached start Date changer and got the date $endDate");
    state = state.copyWith(endDate: endDate,);
  }

  onSearchNameChanged(){

  }


}

final bookingsPageViewModelProvider = StateNotifierProvider<BookingsPageViewModel, BookingsPageState>((ref){
  final repository = ref.watch(bookingRepositoryProvider);
  return BookingsPageViewModel(repository: repository);

});