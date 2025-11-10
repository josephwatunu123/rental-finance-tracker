import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final int? id;
  final int? amount;
  final String? expenseTitle;
  final String? expenseType;
  final String? paymentMethod;
  final String? paymentReference;
  final DateTime? paymentDate;
  final String? notes;
  final String? reminder;

  ExpenseModel({
    this.id,
    this.expenseTitle,
    this.amount,
    this.expenseType,
    this.paymentMethod,
    this.notes,
    this.paymentReference,
    this.reminder,
    this.paymentDate,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as int?,
      expenseType: json['expenseType'] as String?,
      expenseTitle: json['expenseTitle'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentDate:
          json['paymentDate'] != null
              ? (json['paymentDate'] as Timestamp).toDate()
              : null,
      amount: json['amount'] != null ? (json['amount'] as num?)?.toInt() : null,
      notes: json['notes'] as String?,
      reminder: json['reminder'] as String?,
      paymentReference: json['paymentReference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expenseType': expenseType,
      'expenseTitle': expenseTitle,
      'paymentDate':
          paymentDate != null ? Timestamp.fromDate(paymentDate!) : null,
      'paymentMethod': paymentMethod,
      'amount': amount,
      'notes': notes,
      'reminder': reminder,
      'paymentReference': paymentReference,
    };
  }

  @override
  String toString() {
    return 'ExpenseModel(expense: $expenseTitle, date: $paymentDate, amount: $amount, paymentMethod: $paymentMethod, paymentRef: $paymentReference, reminder: $reminder, notes: $notes)';
  }
}
