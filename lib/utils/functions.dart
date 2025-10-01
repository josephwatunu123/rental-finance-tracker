

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
///Trim the date from firebase respnse
String? formatDate(DateTime? date) {
  if(date ==null) return null;
  return "${date.year.toString().padLeft(4,'0')}-"
      "${date.month.toString().padLeft(2,'0')}-"
      "${date.day.toString().padLeft(2,'0')}";
}


