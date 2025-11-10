class NewExpensesState {
  final String? expenseType;
  final String? expenseTypeErrMsg;
  final String? paymentMethod;
  final int? amount;
  final String? paymentReference;
  final String? additionalNotes;
  final String? reminder;
  final DateTime? expensePaymentDate;
  final String? error;
  final String? paymentMethErrMsg;
  final String? expenseTitleErrMsg;
  final String? amountErrMsg;
  final String? paymentRefErrMsg;
  final bool isLoading;
  final bool showFormErrors;
  NewExpensesState({
    this.expenseType,
    this.expenseTypeErrMsg,
    this.paymentMethod,
    this.amount,
    this.paymentReference,
    this.additionalNotes,
    this.reminder,
    this.expensePaymentDate,
    this.paymentMethErrMsg,
    this.paymentRefErrMsg,
    this.expenseTitleErrMsg,
    this.amountErrMsg,
    this.showFormErrors = false,
    this.isLoading = false,
    this.error,
  });

  NewExpensesState copyWith({
    String? expenseType,
    String? expenseTypeErrMsg,
    String? paymentMethod,
    int? amount,
    String? paymentMethErrMsg,
    String? expenseTitleErrMsg,
    String? amountErrMsg,
    String? paymentRefErrMsg,
    String? paymentReference,
    String? additionalNotes,
    String? reminder,
    DateTime? expensePaymentDate,
    bool? isLoading,
    bool? showFormErrors,
    String? error,
  }) {
    return NewExpensesState(
      expenseType: expenseType ?? this.expenseType,
      expenseTypeErrMsg: expenseTypeErrMsg ?? this.expenseTypeErrMsg,
      isLoading: isLoading ?? this.isLoading,
      showFormErrors: showFormErrors ?? this.showFormErrors,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      paymentMethErrMsg: paymentMethErrMsg ?? this.paymentMethErrMsg,
      expenseTitleErrMsg: expenseTitleErrMsg ?? this.expenseTitleErrMsg,
      amountErrMsg: amountErrMsg ?? this.amountErrMsg,
      paymentRefErrMsg: paymentRefErrMsg ?? this.paymentRefErrMsg,
      paymentReference: paymentReference ?? this.paymentReference,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      reminder: reminder ?? this.reminder,
      expensePaymentDate: expensePaymentDate ?? this.expensePaymentDate,
      error: error ?? this.error,
    );
  }
}
