import 'package:rental_finance_tracker/models/booking_model.dart';

class HomeViewModelState{
  final List<BookingModel>? bookings;
  final bool isLoading;
  final int? monthToDateTotal;
  final int? monthToDateRevenue;
  final int? monthBookedDays;
  final String? error;
  HomeViewModelState({
    this.bookings,
    this.monthToDateTotal,
    this.monthToDateRevenue,
    this.monthBookedDays,
    this.isLoading=false,
    this.error

});

  HomeViewModelState copyWith({
    List<BookingModel>? bookings,
    bool? isLoading,
    int? monthToDateTotal,
    int? monthToDateRevenue,
    int? monthBookedDays,
    String? error

  }) {
    return HomeViewModelState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      monthToDateTotal: monthToDateTotal ?? this.monthToDateTotal,
      monthToDateRevenue: monthToDateRevenue ?? this.monthToDateRevenue,
      monthBookedDays: monthBookedDays ?? this.monthBookedDays,
      error: error ?? this.error
    );
  }
}