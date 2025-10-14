import 'package:rental_finance_tracker/models/expense_model.dart';

abstract class ExpenseRepository{
  Future<List<ExpenseModel>> getBookings();
  Future<void> addExpense(ExpenseModel expense);
}