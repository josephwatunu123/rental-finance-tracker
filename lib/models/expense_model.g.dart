// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) =>
    _ExpenseModel(
      id: (json['id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      expenseType: json['expenseType'] as String?,
      paymentRef: json['paymentRef'] as String?,
      notes: json['notes'] as String?,
      ref: json['ref'] as String?,
    );

Map<String, dynamic> _$ExpenseModelToJson(_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'expenseType': instance.expenseType,
      'paymentRef': instance.paymentRef,
      'notes': instance.notes,
      'ref': instance.ref,
    };
