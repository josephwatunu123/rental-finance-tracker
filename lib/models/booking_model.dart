import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final int? id;
  final String? name;
  final DateTime? from;
  final DateTime? to;
  final String? paymentMethod;
  final int? amountPaid;
  final String? bookingSource;
  final String? status;
  final String? notes;
  final String? reminder;
  final String? paymentRef;
  final int? daysBooked;

  BookingModel({
    this.id,
    this.name,
    this.from,
    this.to,
    this.paymentMethod,
    this.amountPaid,
    this.bookingSource,
    this.status,
    this.notes,
    this.reminder,
    this.paymentRef,
    this.daysBooked
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      from: json['from'] != null ? (json['from'] as Timestamp).toDate() : null,
      to: json['to'] != null ? (json['to'] as Timestamp).toDate() : null,
      paymentMethod: json['paymentMethod'] as String?,
      amountPaid: json['amountPaid'] != null ? (json['amountPaid'] as num?)?.toInt() : null,
      bookingSource: json['bookingSource'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      reminder: json['reminder'] as String?,
      paymentRef: json['paymentRef'] as String?,
      daysBooked: json['daysBooked'] as int?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'from': from != null ? Timestamp.fromDate(from!) : null,
      'to': to != null ? Timestamp.fromDate(to!) : null,
      'paymentMethod': paymentMethod,
      'amountPaid': amountPaid,
      'bookingSource': bookingSource,
      'status': status,
      'notes': notes,
      'reminder': reminder,
      'daysBooked': daysBooked
    };
  }

  @override
  String toString() {
    return 'BookingModel(name: $name, from: $from, to: $to, amountPaid: $amountPaid, paymentMethod: $paymentMethod, paymentRef: $paymentRef, bookingSource: $bookingSource, reminder: $reminder, notes: $notes, daysBooked: $daysBooked)';
  }
}