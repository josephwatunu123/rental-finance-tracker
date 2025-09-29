// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      payment_method: json['payment_method'] as String?,
      booking_source: json['booking_source'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      reminder: json['reminder'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from,
      'to': instance.to,
      'payment_method': instance.payment_method,
      'booking_source': instance.booking_source,
      'status': instance.status,
      'notes': instance.notes,
      'reminder': instance.reminder,
    };
