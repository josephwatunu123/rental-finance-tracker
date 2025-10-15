import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/data/firebase_expense_repo_impl.dart';
import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/features/expense/new_expenses_state.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';
import 'package:rental_finance_tracker/utils/form_fields_mixin.dart';

class NewExpensesViewModel extends StateNotifier<NewExpensesState>
    with FormFieldsMixin {
  final ExpenseRepository repository;

  NewExpensesViewModel({required this.repository}) : super(NewExpensesState());

  onPaymentMethodChanged(String? val) {
    state = state.copyWith(
      paymentMethod: val,
      paymentMethErrMsg: val == null ? 'Select payment method' : null,
    );
  }

  void onCreateNewExpense() async {
    final validation = validateCommonFields(paymentMethod: state.paymentMethod);

    state = state.copyWith(
      expenseTitleErrMsg: validation['nameErr'],
      amountErrMsg: validation['amountErr'],
      paymentRefErrMsg: validation['paymentRefErr'],
      paymentMethErrMsg: validation['paymentMethodErr'],
      showFormErrors: true,
    );

    final isValid = validation.values.every((e) => e == null);

    if (!isValid) {
      showErrorSnack('Failed to Create Booking');
      return;
    }

    state = state.copyWith(isLoading: true);

    final expense = ExpenseModel(
      expenseTitle: nameController.text,
      paymentDate: state.expensePaymentDate,
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
