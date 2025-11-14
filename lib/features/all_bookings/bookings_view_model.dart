import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/features/create_booking/presentation/new_booking_view.dart';

import 'bookings_state.dart';

class BookingsPageViewModel extends StateNotifier<BookingsPageState> {
  final BookingRepository repository;

  BookingsPageViewModel({required this.repository})
    : super(BookingsPageState()) {
    init();
  }

  DateTime initialStartDate = AppConstants.thisMonth;
  DateTime initialEndDate = AppConstants.lastDayOfCurrentMonth;
  String? searchName;

  Future<void> init() async {
    state = state.copyWith(
      isLoading: true,
      startDate: initialStartDate,
      endDate: initialEndDate,
    );
    await getBookings(initialStartDate, initialEndDate);
    state = state.copyWith(isLoading: false);
  }

  getBookings(DateTime startDate, DateTime endDate) async {
    state = state.copyWith(isLoading: true);
    var fetchedBookings = await repository.getBookingsList(
      startDate: startDate,
      endDate: endDate,
      searchName: searchName,
    );
    if (fetchedBookings != null) {
      state = state.copyWith(bookings: fetchedBookings, isLoading: false);
    }
  }

  onStartDateChanged(DateTime? selectedStartDate) {
    if (selectedStartDate == null) return;
    state = state.copyWith(startDate: selectedStartDate);
    getBookings(selectedStartDate, endDate);
  }

  onEndDateChanged(DateTime? selectedEndDate) {
    if (selectedEndDate == null) return;
    state = state.copyWith(endDate: selectedEndDate);
    getBookings(startDate, selectedEndDate);
  }

  onSearchNameChanged() {}

  Future<void> onRefresh() async {
    await init();
  }
}

final bookingsPageViewModelProvider =
    StateNotifierProvider<BookingsPageViewModel, BookingsPageState>((ref) {
      final repository = ref.watch(bookingRepositoryProvider);
      return BookingsPageViewModel(repository: repository);
    });
