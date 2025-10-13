import 'package:rental_finance_tracker/models/booking_model.dart';

class NewBookingsState {
  final List<BookingModel>? bookings;
  final bool isLoading;
  final String? bookingStatus;
  final String? error;
  final String? name;
  final DateTime? from;
  final DateTime? to;
  final String? bookingSource;
  final String? paymentMethod;
  final String? nameErrMessage;
  final String? amountErrMessage;
  final String? paymentRefErrMsg;
  final String? paymentMethErrMsg;
  final String? selectedExpenseTypeErrorMsg;
  final String? selectedBookingStatusErrMsg;
  final String? selectedBookingSrcErrMsg;
  final bool? showFormErrors;
  final String? reminder;
  final String? paymentRef;
  final String? notes;
  final bool isSingleDayClient;
  final bool? isViewFormValid;

  NewBookingsState({
    this.bookings,
    this.bookingSource,
    this.paymentMethod,
    this.nameErrMessage,
    this.amountErrMessage,
    this.paymentRefErrMsg,
    this.selectedBookingSrcErrMsg,
    this.selectedExpenseTypeErrorMsg,
    this.selectedBookingStatusErrMsg,
    this.notes,
    this.reminder,
    this.paymentRef,
    this.from,
    this.to,
    this.isLoading = false,
    this.error,
    this.bookingStatus,
    this.showFormErrors,
    this.isViewFormValid,
    this.paymentMethErrMsg,
    this.name,
    this.isSingleDayClient=false
  });

  NewBookingsState copyWith({
    List<BookingModel>? bookings,
    bool? isLoading,
    String? bookingSource,
    String? paymentMethod,
    String? nameErrMessage,
    String? amountErrMessage,
    String? paymentRefErrMsg,
    String? selectedExpenseTypeErrorMsg,
    String? selectedBookingStatusErrMsg,
    String? selectedBookingSrcErrMsg,
    String? name,
    String? reminder,
    String? notes,
    bool? showFormErrors,
    bool? isViewFormValid,
    String? error,
    DateTime? from,
    DateTime? to,
    String? paymentRef,
    String? bookingStatus,
    String? paymentMethErrMsg,
    bool? isSingleDayClient
  }) {
    return NewBookingsState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      bookingSource: bookingSource ?? this.bookingSource,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      nameErrMessage: nameErrMessage ?? this.nameErrMessage,
      amountErrMessage: amountErrMessage ?? this.amountErrMessage,
      paymentRefErrMsg: paymentRefErrMsg ?? this.paymentRefErrMsg,
      selectedExpenseTypeErrorMsg: selectedExpenseTypeErrorMsg ?? this.selectedExpenseTypeErrorMsg,
      selectedBookingStatusErrMsg: selectedBookingStatusErrMsg ?? this.selectedBookingStatusErrMsg,
      selectedBookingSrcErrMsg: selectedBookingSrcErrMsg ?? this.selectedBookingSrcErrMsg,
      showFormErrors: showFormErrors ?? this.showFormErrors,
      isViewFormValid: isViewFormValid ?? this.isViewFormValid,
      from: from ?? this.from,
      to: to ?? this.to,
      error: error ?? this.error,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      reminder: reminder ?? this.reminder,
      paymentRef: paymentRef ?? this.paymentRef,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      paymentMethErrMsg: paymentMethErrMsg ?? this.paymentMethErrMsg,
      isSingleDayClient: isSingleDayClient ?? this.isSingleDayClient
    );
  }
}
