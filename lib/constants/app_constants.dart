class AppConstants {
  ///Date and Time----------------------------
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static final months = List.generate(12, (i) => DateTime(2025, i + 1, 1));
  static DateTime get tomorrow => today.add(const Duration(days: 1));
  static DateTime get yesterday => today.subtract(const Duration(days: 1));
  static final DateTime thisYear = DateTime(today.year, 1, 1);
  static final DateTime nextYear = DateTime(today.year + 1, 1, 1);
  static final DateTime thisMonth = DateTime(today.year, today.month, 1);
  static final firstDayOfCurrentMonth = DateTime(today.year, today.month, 1);
  static final lastDayOfPreviousMonth = firstDayOfCurrentMonth.subtract(
    Duration(days: 1),
  );
  static final firstDayOfPreviousMonth = DateTime(
    lastDayOfPreviousMonth.year,
    lastDayOfPreviousMonth.month,
    1,
  );
  static DateTime get lastDayOfCurrentMonth {
    final now = DateTime.now();
    final beginningNextMonth =
        (now.month < 12)
            ? DateTime(now.year, now.month + 1, 1)
            : DateTime(now.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(milliseconds: 1));
  }

  ///Visual constants------------------------------
  static const double borderRadiusMain = 12;
  static const double borderRadiusSmall = 8;
  static const double borderRadiusLarge = 16;

  ///Lists----------------------------------------
  static const List<String> bookingSources = [
    'referral',
    'airbnb',
    'direct',
    'booking.com',
  ];
  static const List<String> paymentMethods = [
    'MPESA',
    'Bank',
    'Cash',
    'App',
    'Other',
  ];
  static const List<String> bookingStatus = ['confirmed', 'pending', 'partial'];
  static const List<String> apartments = ['City Oasis'];
  static const List<String> expenseTypes = [
    'cleaning',
    'repair',
    'purchase',
    'rent',
    'damage',
  ];

  ///Assets-------------------------------
  static const String noItemsImage = "assets/no_items.gif";
  static const String loadingSquareGif = "assets/loading_square.gif";
  static const String dotsLoadingGif = "assets/dots_loading.gif";
  static const String bookingsLoadingGif = "assets/bookings_loading.gif";
  static const String buttonLoading = "assets/button_loading.gif";
}
