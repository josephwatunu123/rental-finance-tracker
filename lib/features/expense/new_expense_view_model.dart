import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/data/firebase_expense_repo_impl.dart';
import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/features/expense/new_expenses_state.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

class NewExpensesViewModel extends StateNotifier<NewExpensesState> {
  final ExpenseRepository repository;

  NewExpensesViewModel({required this.repository}) : super(NewExpensesState());

  final expenseNameController = TextEditingController();
  final paymentDate = TextEditingController();
  final amountController = TextEditingController();
  final paymentRefController = TextEditingController();
  final notesController = TextEditingController();
  final reminderController = TextEditingController();
  final defaultDate = AppConstants.today;
  bool isViewFormValid = false;

  onPaymentMethodChanged(String? val) {
    state = state.copyWith(
      paymentMethod: val,
      paymentMethErrMsg: val != null ? null : "Please select a payment method",
    );
  }

  onExpenseTypeChanged(String? val) {
    state = state.copyWith(
      expenseType: val,
      expenseTypeErrMsg: val != null ? null : "Please select an expense type",
    );
  }

  void onSelectPaymentDate(DateTime? date) {
    state = state.copyWith(expensePaymentDate: date);
  }

  void clearErrors() {
    state = state.copyWith(
      expenseTitleErrMsg: null,
      amountErrMsg: null,
      paymentRefErrMsg: null,
      paymentMethErrMsg: null,
    );
  }

  void onCreateNewExpense() async {
    state = state.copyWith(isLoading: true);
    clearErrors();
    final titleErr = textFormValidator(expenseNameController.text);
    final expenseTypeErr =
        state.expenseType == null ? "Select an expense type" : null;
    final paymentMethodErr =
        state.paymentMethod == null ? "Select payment method" : null;
    final amountErr = intValidator(amountController.text);
    final paymentRefErr = nonNullTextValidator(paymentRefController.text);

    state = state.copyWith(
      expenseTitleErrMsg: titleErr,
      expenseTypeErrMsg: expenseTypeErr,
      paymentMethErrMsg: paymentMethodErr,
      amountErrMsg: amountErr,
      paymentRefErrMsg: paymentRefErr,
    );
    final isValid = [
      titleErr,
      expenseTypeErr,
      paymentMethodErr,
      amountErr,
      paymentRefErr,
    ].every((e) => e == null);

    if (!isValid) {
      SnackBarService.show(
        message: 'Please Fill All the Details',
        title: 'Failed To Create Booking',
        snackBarType: SnackBarType.error,
      );
      return;
    }

    final expense = ExpenseModel(
      expenseTitle: expenseNameController.text,
      expenseType: state.expenseType,
      paymentDate: state.expensePaymentDate ?? defaultDate,
      amount: int.tryParse(amountController.text),
      paymentMethod: state.paymentMethod,
      paymentReference: paymentRefController.text,
      reminder: reminderController.text,
      notes: notesController.text,
    );

    final res = await repository.addExpense(expense);
    final success = res.keys.first;
    final message = res.values.first;

    SnackBarService.show(
      message: '',
      title: message,
      snackBarType: success ? SnackBarType.success : SnackBarType.error,
    );

    state = state.copyWith(isLoading: false);
  }
}

final newExpenseViewModelProvider =
    StateNotifierProvider<NewExpensesViewModel, NewExpensesState>((ref) {
      final repo = ref.watch(expenseRepositoryProvider);
      return NewExpensesViewModel(repository: repo);
    });
