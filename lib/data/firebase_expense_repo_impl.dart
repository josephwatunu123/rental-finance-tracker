import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';

class FirebaseExpenseImplementation implements ExpenseRepository {
  final FirebaseFirestore firestore;

  FirebaseExpenseImplementation(this.firestore);
  @override
  Future<Map<bool, String>> addExpense(ExpenseModel expense) async {
    log("Booking to be submitted::: ${expense.toString()}");
    try {
      await firestore.collection('expenses').add(expense.toJson());
      return {true: 'Successfully Created Expense.'};
    } catch (e, st) {
      log("error creating expense::: $e, $st");
      return {false: 'Error: $e'};
    }
  }

  @override
  Future<List<ExpenseModel>> getBookings() {
    // TODO: implement getBookings
    throw UnimplementedError();
  }
}

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return FirebaseExpenseImplementation(FirebaseFirestore.instance);
});
