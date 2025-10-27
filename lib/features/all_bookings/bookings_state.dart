

import 'package:rental_finance_tracker/models/booking_model.dart';

class BookingsPageState{
  final String? error;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<BookingModel>? bookings;
  final bool isLoading;

  BookingsPageState({
    this.error,
    this.startDate,
    this.endDate,
    this.bookings,
    this.isLoading=false,
});

  BookingsPageState copyWith({
    String? error,
    DateTime? startDate,
    DateTime? endDate,
    List<BookingModel>? bookings,
    bool? isLoading,
}) {
    return BookingsPageState(
      error: error ?? this.error,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading
    );
  }

}