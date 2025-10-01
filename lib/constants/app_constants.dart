class AppConstants{

//Date and Time
  static DateTime get today => DateTime.now();
  static DateTime get tomorrow => today.add(const Duration(days: 1));
  static DateTime get yesterday => today.subtract(const Duration(days: 1));
  static final DateTime thisYear = DateTime(today.year, 1, 1);
  static final DateTime thisMonth = DateTime(today.year, today.month, 1);
  static final firstDayOfCurrentMonth = DateTime(today.year, today.month, 1);
  static final lastDayOfPreviousMonth = firstDayOfCurrentMonth.subtract(Duration(days: 1));
  static final firstDayOfPreviousMonth = DateTime(lastDayOfPreviousMonth.year, lastDayOfPreviousMonth.month, 1);

//Visual constants
  static const double borderRadiusMain = 12;
  static const double borderRadiusSmall =8;
  static const double borderRadiusLarge = 16;

//Lists
  static const List<String> bookingSources = [
    'referral',
    'airbnb',
    'direct',
    'booking.com'
  ];
  static const List<String> paymentMethods = [
    'MPESA',
    'Bank',
    'Cash',
    'App',
    'Other'
  ];
  static const List<String> bookingStatus = [
    'confirmed',
    'pending',
    'partial',
  ];
  static const List<String> apartments = [
    'City Oasis',
  ];
  static const List<String> expenseTypes = [
    'cleaning',
    'repair',
    'purchase',
    'rent',
    'damage'
  ];
}