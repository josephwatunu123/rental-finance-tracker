import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/features/home/home_view_state.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class HomePageViewModel extends StateNotifier<HomeViewState>{
  final BookingRepository repository;


  HomePageViewModel({required this.repository}): super(HomeViewState()){
    loadBookings();
    getBookingSources();
  }

  final startDate = AppConstants.thisMonth;
  final endDate = AppConstants.lastDayOfCurrentMonth;
  final List<String> bookingSources = AppConstants.bookingSources;

  Future<void> loadBookings() async{
    state = state.copyWith(isLoading: true,);
    try{
      final bookings = await repository.getBookings(
          startDate: startDate,
          endDate: endDate);
      state= state.copyWith(
          bookings: bookings,
          monthToDateTotal:bookings?.length,
          monthToDateRevenue: getCurrentMonthTotalRevenue(bookings),
          monthBookedDays: calculateBookedDays(bookings, startDate,endDate),
          recentBookings: bookings == null ? [] : bookings.length <=5 ? bookings : bookings.sublist(bookings.length -5)
      );
      state = state.copyWith(isLoading: false);
    }catch (e, st){
      debugPrint("error::: $e,stack:::$st");
      state =state.copyWith(isLoading: false, error: e.toString());
    }
  }

  int getCurrentMonthTotalRevenue(List<BookingModel>? bookings) {
    if (bookings == null || bookings.isEmpty) return -1;
    final total = bookings.fold(0, (sum, b) => sum + (b.amountPaid ?? 0));
    log("current month revenue::: $total");
    return total;
  }

  int getCurrentMonthProfit(List<BookingModel>? bookings){
    if(bookings == null || bookings.isEmpty) return -1;
    final total = bookings.fold(0, (sum, b) => sum + (b.amountPaid ?? 0));
    log("current month revenue::: $total");
    return total;
  }

  int calculateBookedDays(List<BookingModel>? bookings, DateTime monthStart, DateTime monthEnd) {
    if (bookings == null || bookings.isEmpty) return -1;
    int totalDays = 0;
    for (var b in bookings) {
      final start = b.from!.isBefore(monthStart) ? monthStart : b.from!;
      final end = b.to!.isAfter(monthEnd) ? monthEnd : b.to!;
      final days = end.difference(start).inDays + 1;
      totalDays += days;
    }
    return totalDays;
  }

  Future<void> getBookingSources() async {
    final results = await Future.wait(
      bookingSources.map((source) =>
          repository.getTotalBookingsFromSource(
              source: source,
              startDate: startDate,
              endDate: endDate
          )),
    );
    final Map<String, int> counts = {
      for (int i = 0; i < bookingSources.length; i++)
        bookingSources[i]: results[i]?.toInt() ?? 0,
    };
    state = state.copyWith(
      bookingsFromAirbnb: counts['airbnb'],
      bookingsFromReferral: counts['referral'],
      directBookings: counts['direct'],
      bookingsFromBookingDotCom: counts['booking.com'],
    );
  }


  Future<void> onRefresh() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await loadBookings();
      await getBookingSources();
    } catch (e, st) {
      debugPrint("Refresh error::: $e, stack:::$st");
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }







}

final homePageViewModelProvider = StateNotifierProvider<HomePageViewModel, HomeViewState>((ref){
  final repository = ref.watch(bookingRepositoryProvider);
  return HomePageViewModel(repository: repository);
});
