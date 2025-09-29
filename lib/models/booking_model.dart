import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.g.dart';
part 'booking_model.freezed.dart';

@freezed
abstract class BookingModel with _$BookingModel {
  const factory BookingModel({
  int? id,
  String? name,
  String? from,
  String? to,
  String? payment_method,
  String? booking_source,
  String? status,
  String? notes,
  String? reminder,
 }) = _BookingModel;

 factory BookingModel.fromJson(Map<String, dynamic> json) =>
     _$BookingModelFromJson(json);
}
