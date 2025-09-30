

//Date and Time
final today = DateTime.now();
final yesterday = today.subtract(const Duration(days: 1));
final thisYear = DateTime(today.year, 1, 1);
final thisMonth = DateTime(today.year, today.month, 1);

//Visual constants
const double borderRadiusMain = 12;
const double borderRadiusSmall =8;
const double borderRadiusLarge = 16;

//Lists
const List<String> bookingSources = [
  'referral',
  'airbnb',
  'direct',
  'booking.com'
];
const List<String> paymentMethods = [
  'MPESA',
  'Bank',
  'Cash',
  'App',
  'Other'
];
const List<String> bookingStatus = [
  'confirmed',
  'pending',
  'partial',
];
const List<String> apartments = [
  'City Oasis',
];
const List<String> expenseTypes = [
  'cleaning',
  'repair',
  'purchase',
  'rent',
  'damage'
];