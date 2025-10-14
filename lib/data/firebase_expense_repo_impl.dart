import 'package:rental_finance_tracker/domain/expense_repository.dart';
import 'package:rental_finance_tracker/models/expense_model.dart';

class FirebaseExpenseImplementation implements ExpenseRepository{
  @override
  Future<void> addExpense(ExpenseModel expense) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future<List<ExpenseModel>> getBookings() {
    // TODO: implement getBookings
    throw UnimplementedError();
  }

}
