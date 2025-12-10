import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/data/firebase_expense_repo_impl.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/features/home/home_view_state.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';

class HomePageViewModel extends StateNotifier<HomeViewState> {
  final BookingRepository bookingRepository;
  final ExpenseRepository expenseRepository;

  HomePageViewModel({
    required this.bookingRepository,
    required this.expenseRepository,
  }) : super(HomeViewState()) {
    onInit();
  }

  onInit({DateTime? start, DateTime? end}) async {
    state = state.copyWith(
      isLoading: true,
      startDate: start ?? AppConstants.thisMonth,
      endDate: end ?? AppConstants.lastDayOfCurrentMonth,
    );
    await loadBookings();
    await getBookingSources();
    await loadExpenses();
    calculateProfit();
    state = state.copyWith(isLoading: false);
  }

  final List<String> bookingSources = AppConstants.bookingSources;

  Future<void> loadBookings() async {
    state = state.copyWith(isLoading: true);
    try {
      final bookings = await bookingRepository.getBookings(
        startDate: state.startDate!,
        endDate: state.endDate!,
      );
      state = state.copyWith(
        bookings: bookings,
        monthToDateTotalBookings: bookings?.length,
        monthToDateRevenue: getCurrentMonthTotalRevenue(bookings),
        monthBookedDays: calculateBookedDays(
          bookings,
          state.startDate!,
          state.endDate!,
        ),
        recentBookings:
            bookings == null
                ? []
                : bookings.length <= 5
                ? bookings
                : bookings.sublist(bookings.length - 5),
      );
      state = state.copyWith(isLoading: false);
    } catch (e, st) {
      debugPrint("error::: $e,stack:::$st");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadExpenses() async {
    state = state.copyWith(isLoading: true);
    final expenses = await expenseRepository.getExpenses(
      startDate: state.startDate!,
      endDate: state.endDate!,
    );
    state = state.copyWith(
      expenses: expenses,
      monthToDateTotalExpensesAmt: getCurrentMonthTotalExpenses(expenses),
      isLoading: false,
    );
  }

  onChangeMonthFilter(DateTime? selectedDate) async {
    if (selectedDate == null) return;
    DateTime lastDayOfSelectedMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );
    await onInit(start: selectedDate, end: lastDayOfSelectedMonth);
  }

  double getCurrentMonthTotalRevenue(List<BookingModel>? bookings) {
    if (bookings == null) return -1;
    final double total = bookings.fold(
      0,
      (sum, b) => sum + (b.amountPaid ?? 0),
    );
    log("current month revenue::: $total");
    return total;
  }

  double getCurrentMonthTotalExpenses(List<ExpenseModel>? expenses) {
    if (expenses == null) return -1;
    final double total = expenses.fold(0, (sum, b) => sum + (b.amount ?? 0));
    log("current month total expenses::: $total");
    return total;
  }

  double getCurrentMonthProfit(List<BookingModel>? bookings) {
    if (bookings == null || bookings.isEmpty) return -1;
    final double total = bookings.fold(
      0,
      (sum, b) => sum + (b.amountPaid ?? 0.0),
    );
    log("current month revenue::: $total");
    return total;
  }

  int calculateBookedDays(
    List<BookingModel>? bookings,
    DateTime monthStart,
    DateTime monthEnd,
  ) {
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

  calculateProfit() {
    double profit =
        (state.monthToDateRevenue ?? 0) -
        (state.monthToDateTotalExpensesAmt ?? 0);
    state = state.copyWith(profit: profit);
  }

  Future<void> getBookingSources() async {
    final results = await Future.wait(
      bookingSources.map(
        (source) => bookingRepository.getTotalBookingsFromSource(
          source: source,
          startDate: state.startDate!,
          endDate: state.endDate!,
        ),
      ),
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
    await onInit();
  }
}

final homePageViewModelProvider =
    StateNotifierProvider<HomePageViewModel, HomeViewState>((ref) {
      final bookingRepo = ref.watch(bookingRepositoryProvider);
      final expenseRepo = ref.watch(expenseRepositoryProvider);
      return HomePageViewModel(
        bookingRepository: bookingRepo,
        expenseRepository: expenseRepo,
      );
    });
