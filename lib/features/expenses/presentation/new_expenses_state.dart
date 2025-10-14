
class NewExpensesState{
  final String? expenseType;
  final String? paymentMethod;
  final int? amount;
  final String? paymentReference;
  final String? additionalNotes;
  final String? reminder;
  final DateTime? expensePaymentDate;
  final String? error;
  final bool isLoading;
  NewExpensesState({
    this.expenseType,
    this.paymentMethod,
    this.amount,
    this.paymentReference,
    this.additionalNotes,
    this.reminder,
    this.expensePaymentDate,
    this.isLoading=false,
    this.error

  });

  NewExpensesState copyWith({
    String? expenseType,
    String? paymentMethod,
    int? amount,
    String? paymentReference,
    String? additionalNotes,
    String? reminder,
    DateTime? expensePaymentDate,
    bool? isLoading,
    String? error

  }) {
    return NewExpensesState(
        expenseType: expenseType ?? this.expenseType,
        isLoading: isLoading ?? this.isLoading,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        amount: amount ?? this.amount,
        paymentReference: paymentReference ?? this.paymentReference,
        additionalNotes: additionalNotes ?? this.additionalNotes,
        reminder: reminder ?? this.reminder,
        expensePaymentDate: expensePaymentDate ?? this.expensePaymentDate,
        error: error ?? this.error
    );
  }
}