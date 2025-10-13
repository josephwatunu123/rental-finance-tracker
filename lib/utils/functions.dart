

///Basic function to validate a Text form:
//we will check for nullability and invalid
String? textFormValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a value";
  }
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegExp.hasMatch(value)) {
    return "Only letters are allowed";
  }
  return null;
}

///Basic function to validate a Text form without regex:
//we will check for nullability and invalid
String? nonNullTextValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a value";
  }
  return null;
}

///Basic function to validate a number form:
//we will check for nullability and invalid
String? intValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a value";
  }
  final int? intValue = int.tryParse(value);
  if (intValue == null) {
    return "Please enter a valid integer";
  }
  if (intValue <= 0) {
    return "Value must be greater than zero";
  }
  return null;
}


///Trim the date from firebase response
String? formatDate(DateTime? date) {
  if(date ==null) return null;
  return "${date.day.toString().padLeft(2,'0')}-"
      "${date.month.toString().padLeft(2,'0')}-"
      "${date.year.toString().padLeft(2,'0')}";
}


///Function to calculate the number of days booked
int? calculateBookedDays(DateTime? fromDate, DateTime? toDate) {
  if(fromDate ==null || toDate==null){
    return -1;
  }
  final start = DateTime(fromDate.year, fromDate.month, fromDate.day);
  final end = DateTime(toDate.year, toDate.month, toDate.day);
  return end.difference(start).inDays;
}


