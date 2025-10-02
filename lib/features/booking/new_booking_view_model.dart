

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/booking_repository.dart';
import 'package:rental_finance_tracker/data/firebase_booking_repo_implementation.dart';
import 'package:rental_finance_tracker/utils/functions.dart';
import 'package:rental_finance_tracker/models/booking_model.dart';

class NewBookingViewModel extends StateNotifier<AsyncValue<BookingModel>>{
  final BookingRepository repository;
  final nameController = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final amountController = TextEditingController();
  final paymentReferenceController = TextEditingController();
  final notesController = TextEditingController();
  final reminderController = TextEditingController();
  String? bookingStatus;
  String? bookingSource;
  String? paymentMethod;
  String? nameErrMessage;
  String? amountErrMessage;
  String? paymentRefErrMsg;
  String? selectedExpenseTypeErrorMsg;
  String? selectedBookingStatusErrMsg;
  String? selectedBookingSrcErrMsg;
  bool isViewFormValid = false;
  bool isLoading = false;
  bool showFormErrors = false;
  late final BookingModel newBooking;

  NewBookingViewModel(this.repository): super(const AsyncValue.loading());

  Future<void> addNewBooking(BookingModel booking) async{
    try{
      repository.addBooking(booking);
      state = AsyncValue.data(booking);
    }catch (e, st){
      log("error::: $e, stack ::: $st");
      state = AsyncValue.error(e,st);
    }

  }


  onPaymentMethodChanged(String? val) {
    paymentMethod = val;
    selectedExpenseTypeErrorMsg = null;
    state = AsyncValue.data(state.value ?? BookingModel());
  }
  onBookingSrcChanged(String? val) {
    bookingSource = val;
    selectedExpenseTypeErrorMsg = null;
    state = AsyncValue.data(state.value ?? BookingModel());
  }
  onBookingStatusChanged(String? val) {
    bookingStatus = val;
    selectedExpenseTypeErrorMsg = null;
    state = AsyncValue.data(state.value ?? BookingModel());
  }

  bool isFormValid() {
    return textFormValidator(nameController.text) == null &&
        textFormValidator(paymentReferenceController.text) == null &&
        intValidator(amountController.text) == null &&
        selectedExpenseTypeErrorMsg == null &&
        selectedBookingStatusErrMsg == null &&
        selectedBookingSrcErrMsg == null;
  }

  void preValidateForm() {
    nameErrMessage = textFormValidator(nameController.text);
    paymentRefErrMsg = nonNullTextValidator(paymentReferenceController.text);
    amountErrMessage = intValidator(amountController.text);
    selectedExpenseTypeErrorMsg = paymentMethod == null ? 'Please select a payment method' : null;
    selectedBookingSrcErrMsg = bookingSource == null ? 'Please select a booking source' : null;
    selectedBookingStatusErrMsg = bookingStatus == null ? 'Please select a booking status' : null;
  }

  void onCreateNewBooking() {
    debugPrint("Reached On Create view");
    preValidateForm();
    if (!isFormValid()) {
      showFormErrors = true;
      state = AsyncValue.data(state.value ?? BookingModel());
      return;
    }
    showFormErrors = false;
    debugPrint("Success: Booking created");
    state = AsyncValue.data(state.value ?? BookingModel());
  }



}

final newBookingViewModelProvider = StateNotifierProvider<NewBookingViewModel, AsyncValue<BookingModel>>((ref) {
  final repo = ref.watch(bookingRepositoryProvider);
  return NewBookingViewModel(repo);
});