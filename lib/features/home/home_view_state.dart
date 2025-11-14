import 'package:rental_finance_tracker/models/booking_model.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';

class HomeViewState {
  final List<BookingModel>? bookings;
  final List<BookingModel>? recentBookings;
  final List<ExpenseModel>? expenses;
  final int? monthToDateTotalExpensesAmt;
  final bool isLoading;
  final int? monthToDateTotalBookings;
  final int? monthToDateRevenue;
  final int? monthBookedDays;
  final int? bookingsFromAirbnb;
  final int? bookingsFromReferral;
  final int? directBookings;
  final int? bookingsFromBookingDotCom;
  final String? error;
  final int? profit;
  HomeViewState({
    this.bookings,
    this.recentBookings,
    this.expenses,
    this.monthToDateTotalBookings,
    this.monthToDateTotalExpensesAmt,
    this.monthToDateRevenue,
    this.monthBookedDays,
    this.bookingsFromAirbnb,
    this.bookingsFromBookingDotCom,
    this.bookingsFromReferral,
    this.directBookings,
    this.isLoading = false,
    this.error,
    this.profit,
  });

  HomeViewState copyWith({
    List<BookingModel>? bookings,
    List<BookingModel>? recentBookings,
    List<ExpenseModel>? expenses,
    bool? isLoading,
    int? monthToDateTotalBookings,
    int? monthToDateTotalExpensesAmt,
    int? monthToDateRevenue,
    int? monthBookedDays,
    int? bookingsFromAirbnb,
    int? bookingsFromReferral,
    int? directBookings,
    int? bookingsFromBookingDotCom,
    String? error,
    int? profit,
  }) {
    return HomeViewState(
      bookings: bookings ?? this.bookings,
      recentBookings: recentBookings ?? this.recentBookings,
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      monthToDateTotalExpensesAmt:
          monthToDateTotalExpensesAmt ?? this.monthToDateTotalExpensesAmt,
      monthToDateTotalBookings:
          monthToDateTotalBookings ?? this.monthToDateTotalBookings,
      monthToDateRevenue: monthToDateRevenue ?? this.monthToDateRevenue,
      monthBookedDays: monthBookedDays ?? this.monthBookedDays,
      bookingsFromAirbnb: bookingsFromAirbnb ?? this.bookingsFromAirbnb,
      bookingsFromBookingDotCom:
          bookingsFromBookingDotCom ?? this.bookingsFromBookingDotCom,
      bookingsFromReferral: bookingsFromReferral ?? this.bookingsFromReferral,
      directBookings: directBookings ?? this.directBookings,
      error: error ?? this.error,
      profit: profit ?? this.profit
    );
  }
}
