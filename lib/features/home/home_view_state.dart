import 'package:rental_finance_tracker/models/booking_model.dart';

class HomeViewModelState{
  final List<BookingModel>? bookings;
  final bool isLoading;
  final int? monthToDateTotal;
  final int? monthToDateRevenue;
  final int? monthBookedDays;
  final int? bookingsFromAirbnb;
  final int? bookingsFromReferral;
  final int? directBookings;
  final int? bookingsFromBookingDotCom;
  final String? error;
  HomeViewModelState({
    this.bookings,
    this.monthToDateTotal,
    this.monthToDateRevenue,
    this.monthBookedDays,
    this.bookingsFromAirbnb,
    this.bookingsFromBookingDotCom,
    this.bookingsFromReferral,
    this.directBookings,
    this.isLoading=false,
    this.error

});

  HomeViewModelState copyWith({
    List<BookingModel>? bookings,
    bool? isLoading,
    int? monthToDateTotal,
    int? monthToDateRevenue,
    int? monthBookedDays,
    int? bookingsFromAirbnb,
    int? bookingsFromReferral,
    int? directBookings,
    int? bookingsFromBookingDotCom,
    String? error

  }) {
    return HomeViewModelState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      monthToDateTotal: monthToDateTotal ?? this.monthToDateTotal,
      monthToDateRevenue: monthToDateRevenue ?? this.monthToDateRevenue,
      monthBookedDays: monthBookedDays ?? this.monthBookedDays,
      bookingsFromAirbnb: bookingsFromAirbnb ?? this.bookingsFromAirbnb,
      bookingsFromBookingDotCom: bookingsFromBookingDotCom ?? this.bookingsFromBookingDotCom,
      bookingsFromReferral: bookingsFromReferral ?? this.bookingsFromReferral,
      directBookings: directBookings ?? this.directBookings,
      error: error ?? this.error
    );
  }
}