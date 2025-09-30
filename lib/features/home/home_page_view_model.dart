import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/booking_repository.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class HomePageViewModel extends StateNotifier<AsyncValue<List<BookingModel>>>{
  final BookingRepository repository;

   int? monthToDateTotal;
   int? monthTotalBookings;
  final DateTime startDate = today;
  final DateTime endDate = thisMonth;

  HomePageViewModel(this.repository): super(const AsyncValue.loading()){
    loadBookings();
  }


  Future<void> loadBookings() async{
    debugPrint("trying to load bookings");
    try{
      final bookings = await repository.getBookings();
      monthToDateTotal = getCurrentMonthTotalRevenue(bookings);
      monthTotalBookings = getTotalBookingsThisMonth(bookings);
      debugPrint("test1::: $monthToDateTotal,test2:::$monthTotalBookings");
      state = AsyncValue.data(bookings);
    }catch (e, st){
      debugPrint("error::: $e,stack:::$st");
      state = AsyncValue.error(e, st);
    }
  }

  int getCurrentMonthTotalRevenue (List<BookingModel>? bookings){
    if(bookings !=null && bookings.isNotEmpty ){
      final currentMonthsRevenue = bookings.where((b)=>
        b.from!.isAfter(startDate)&& b.to!.isBefore(endDate)
      ).toList();

      return currentMonthsRevenue.fold(0, (sum, bookings)=> sum + (bookings.amountPaid ?? 0));
    }
    return 0;
  }

  int getTotalBookingsThisMonth (List<BookingModel>? bookings){
    if(bookings!=null && bookings.isNotEmpty){
      debugPrint("total bookings compute ${bookings.length}");
      return bookings.length;
    }
    return 0;
  }
}

final homePageViewModelProvider =
StateNotifierProvider<HomePageViewModel, AsyncValue<List<BookingModel>>>((ref) {
  final repo = ref.watch(bookingRepositoryProvider);
  return HomePageViewModel(repo);
});
