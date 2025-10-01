import 'package:rental_finance_tracker/models/booking_model.dart';

abstract class BookingRepository{
  Future<List<BookingModel>?> getBookings({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<void> addBooking(BookingModel booking);
}