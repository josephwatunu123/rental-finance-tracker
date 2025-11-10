import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/domain/booking_repository.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';
import 'package:rental_finance_tracker/utils/functions.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

import 'new_bookings_state.dart';

class NewBookingViewModel extends StateNotifier<NewBookingsState> {
  final BookingRepository repository;
  final nameController = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final amountController = TextEditingController();
  final paymentRefController = TextEditingController();
  final notesController = TextEditingController();
  final reminderController = TextEditingController();
  bool isViewFormValid = false;
  late final BookingModel newBooking;
  List<BookingModel> bookings = [];
  final Set<DateTime> blockedDays = {};

  NewBookingViewModel({required this.repository}) : super(NewBookingsState()) {
    onInit();
  }

  onInit() async {
    await getBookingsCurrentYear();
    _getBlockedDaysFromBookings(bookings);
    state = state.copyWith(blockedDays: blockedDays);
  }

  getBookingsCurrentYear() async {
    DateTime startDate = AppConstants.thisYear;
    DateTime endDate = AppConstants.nextYear;
    final fetchedBookings = await repository.getBookings(
      startDate: startDate,
      endDate: endDate,
    );
    if (fetchedBookings != null) {
      bookings = fetchedBookings;
    }
  }

  Future<void> addNewBooking(BookingModel booking) async {
    try {
      repository.addBooking(booking);
    } catch (e, st) {
      log("error::: $e, stack ::: $st");
    }
  }

  onPaymentMethodChanged(String? val) {
    if (val != null) {
      state = state.copyWith(paymentMethErrMsg: null);
    } else {
      state = state.copyWith(paymentMethErrMsg: "select payment method");
    }
    state = state.copyWith(paymentMethod: val);
  }

  onBookingSrcChanged(String? val) {
    if (val != null) {
      state = state.copyWith(selectedBookingSrcErrMsg: null);
    } else {
      state = state.copyWith(selectedBookingSrcErrMsg: "select payment method");
    }
    state = state.copyWith(bookingSource: val);
  }

  onBookingStatusChanged(String? val) {
    if (val != null) {
      state = state.copyWith(selectedBookingStatusErrMsg: null);
    } else {
      state = state.copyWith(
        selectedBookingStatusErrMsg: "select payment method",
      );
    }
    state = state.copyWith(bookingStatus: val);
  }

  void updateDateRange(DateTime from, DateTime to) {
    state = state.copyWith(from: from, to: to);
  }

  onStartDateChanged(DateTime? startDate) {
    state = state.copyWith(from: startDate);
  }

  onEndDateChanged(DateTime? endDate) {
    state = state.copyWith(to: endDate);
  }

  void clearErrors() {
    state = state.copyWith(
      nameErrMessage: null,
      amountErrMessage: null,
      paymentRefErrMsg: null,
      selectedBookingSrcErrMsg: null,
      selectedBookingStatusErrMsg: null,
      selectedExpenseTypeErrorMsg: null,
      paymentMethErrMsg: null,
    );
  }

  Set<DateTime> _getBlockedDaysFromBookings(List<BookingModel> bookings) {
    for (final booking in bookings) {
      final from = booking.from;
      final to = booking.to;

      DateTime current = DateTime(from!.year, from.month, from.day);
      final DateTime end = DateTime(to!.year, to.month, to.day);

      while (current.isBefore(end)) {
        blockedDays.add(current);
        current = current.add(const Duration(days: 1));
      }
    }
    log('Days blocked: $blockedDays');
    return blockedDays;
  }

  void onCreateNewBooking() async {
    clearErrors();
    final nameErr = textFormValidator(nameController.text);
    final amountErr = intValidator(amountController.text);
    final paymentRefErr = nonNullTextValidator(paymentRefController.text);
    final paymentMethodErr =
        state.paymentMethod == null ? "Select payment method" : null;
    final bookingSourceErr =
        state.bookingSource == null ? "Select booking source" : null;
    final bookingStatusErr =
        state.bookingStatus == null ? "Select booking status" : null;

    state = state.copyWith(
      nameErrMessage: nameErr,
      amountErrMessage: amountErr,
      paymentRefErrMsg: paymentRefErr,
      paymentMethErrMsg: paymentMethodErr,
      selectedBookingSrcErrMsg: bookingSourceErr,
      selectedBookingStatusErrMsg: bookingStatusErr,
      showFormErrors: true,
    );
    final isValid = [
      nameErr,
      amountErr,
      paymentRefErr,
      paymentMethodErr,
      bookingSourceErr,
      bookingStatusErr,
    ].every((e) => e == null);

    if (!isValid) {
      SnackBarService.show(
        message: 'Please fill all the fields',
        title: 'Failed to Create Booking',
        snackBarType: SnackBarType.error,
      );
      return;
    }

    state = state.copyWith(isLoading: true);
    final booking = BookingModel(
      name: nameController.text,
      from: state.from,
      to: state.to,
      amountPaid: int.tryParse(amountController.text),
      paymentMethod: state.paymentMethod,
      paymentRef: paymentRefController.text,
      bookingSource: state.bookingSource,
      reminder: reminderController.text,
      notes: notesController.text,
      daysBooked: calculateBookedDays(state.from, state.to),
      status: state.bookingStatus,
    );

    var createBookingRes = await repository.addBooking(booking);
    if (createBookingRes.keys.first == true) {
      SnackBarService.show(
        message: '',
        title: createBookingRes.values.first,
        snackBarType: SnackBarType.success,
      );
      state = state.copyWith(isLoading: false);
    } else {
      SnackBarService.show(
        message: '',
        title: createBookingRes.values.first,
        snackBarType: SnackBarType.error,
      );
      state = state.copyWith(isLoading: false);
    }
  }
}

final newBookingViewModelProvider =
    StateNotifierProvider<NewBookingViewModel, NewBookingsState>((ref) {
      final repo = ref.watch(bookingRepositoryProvider);
      return NewBookingViewModel(repository: repo);
    });
