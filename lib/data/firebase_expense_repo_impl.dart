import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';
import 'package:rental_finance_tracker/services/snackbar_service.dart';

class FirebaseExpenseImplementation implements ExpenseRepository {
  final FirebaseFirestore firestore;

  FirebaseExpenseImplementation(this.firestore);
  @override
  Future<Map<bool, String>> addExpense(ExpenseModel expense) async {
    log("Expense to be submitted::: ${expense.toString()}");
    try {
      await firestore.collection('expenses').add(expense.toJson());
      return {true: 'Successfully Created Expense.'};
    } catch (e, st) {
      log("error creating expense::: $e, $st");
      return {false: 'Error: $e'};
    }
  }

  @override
  Future<List<ExpenseModel>?> getExpenses({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final snapshot =
          await firestore
              .collection('expenses')
              .where(
                'paymentDate',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
              )
              .where(
                'paymentDate',
                isLessThanOrEqualTo: Timestamp.fromDate(endDate),
              )
              .get();
      log(
        'FirebaseExpenseRepository.getExpenses ::: '
        'Found ${snapshot.docs.length} expenses '
        'between $startDate and $endDate. '
        'IDs: ${snapshot.docs.map((d) => d.id).toList()}',
      );
      return snapshot.docs.map((expense) {
        return ExpenseModel.fromJson(expense.data());
      }).toList();
    } catch (e, st) {
      log("error fetching expenses::: $e, $st");
      SnackBarService.show(
        message: '$e',
        title: 'An Error Occurred',
        snackBarType: SnackBarType.error,
      );
      return null;
    }
  }
}

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return FirebaseExpenseImplementation(FirebaseFirestore.instance);
});
