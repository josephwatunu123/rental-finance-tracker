import 'package:rental_finance_tracker/models/booking_model.dart';

abstract class BookingRepository {
  Future<List<BookingModel>?> getBookings({
    required DateTime startDate,
    required DateTime endDate,
    String? searchName,
  });

  Future<Map<bool, String>> addBooking(BookingModel booking);

  Future<double?> getTotalBookingsFromSource({
    required String source,
    DateTime startDate,
    DateTime endDate,
  });

  Future<List<BookingModel>?> getBookingsList({
    required DateTime startDate,
    required DateTime endDate,
    String? searchName,
  });
}
