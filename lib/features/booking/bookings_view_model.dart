import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/features/booking/bookings_state.dart';

class BookingsPageViewModel extends StateNotifier<BookingsPageState>{
  final BookingRepository repository;

  BookingsPageViewModel({required this.repository}) : super(BookingsPageState());


}

final bookingsPageViewModelProvider = StateNotifierProvider<BookingsPageViewModel, BookingsPageState>((ref){
  final repository = ref.watch(bookingRepositoryProvider);
  return BookingsPageViewModel(repository: repository);

});