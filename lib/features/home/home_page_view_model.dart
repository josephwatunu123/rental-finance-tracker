import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/booking_repository.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/features/home/home_view_state.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class HomePageViewModel extends StateNotifier<HomeViewModelState>{
  final BookingRepository repository;


  HomePageViewModel({required this.repository}): super(HomeViewModelState()){
    loadBookings();
  }

  final startDate = AppConstants.today;
  final endDate = AppConstants.lastDayOfCurrentMonth;

  Future<void> loadBookings() async{
    state = state.copyWith(isLoading: true,);
    try{
      final bookings = await repository.getBookings(
          startDate: startDate,
          endDate: endDate);
      state =state.copyWith(bookings: bookings);
      state = state.copyWith(monthToDateTotal:bookings?.length);
      state = state.copyWith(monthToDateRevenue: getCurrentMonthTotalRevenue(bookings));
      state = state.copyWith(isLoading: false);
    }catch (e, st){
      debugPrint("error::: $e,stack:::$st");
      state =state.copyWith(isLoading: false, error: e.toString());
    }
  }

  int getCurrentMonthTotalRevenue (List<BookingModel>? bookings){
    if(bookings !=null && bookings.isNotEmpty ){
      final currentMonthsRevenue = bookings.where((b)=>
        b.from!.isAfter(startDate)&& b.to!.isBefore(endDate)
      ).toList();

      debugPrint("this is bookings from revenue calc: ${bookings.first}");

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

final homePageViewModelProvider = StateNotifierProvider<HomePageViewModel, HomeViewModelState>((ref){
  final repository = ref.watch(bookingRepositoryProvider);
  return HomePageViewModel(repository: repository);
});
