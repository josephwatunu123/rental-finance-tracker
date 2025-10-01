import 'package:cloud_firestore/cloud_firestore.dart';

/// Converts a DateTime object to a Firestore Timestamp.
/// Returns null if the input DateTime is null.
Timestamp? getTimeStamp(DateTime? dateTime) {
  if (dateTime == null) return null;
  return Timestamp.fromDate(dateTime);
}

DateTime? getDateTime(Timestamp? timeStamp) {
  if (timeStamp == null) return null;
  return timeStamp.toDate();
}