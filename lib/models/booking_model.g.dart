// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
      payment_method: json['payment_method'] as String?,
      amountPaid: (json['amountPaid'] as num?)?.toInt(),
      booking_source: json['booking_source'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      reminder: json['reminder'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'payment_method': instance.payment_method,
      'amountPaid': instance.amountPaid,
      'booking_source': instance.booking_source,
      'status': instance.status,
      'notes': instance.notes,
      'reminder': instance.reminder,
    };
