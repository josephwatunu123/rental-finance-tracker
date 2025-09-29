
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
abstract class ExpenseModel with _$ExpenseModel{
  factory ExpenseModel({
    int? id,
    int? amount,
    String? expenseType,
    String? paymentRef,
    String? notes,
    String? ref

}) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}