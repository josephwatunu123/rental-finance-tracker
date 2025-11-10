import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/all_bookings/bookings_view.dart';
import 'package:rental_finance_tracker/features/create_booking/presentation/new_booking_view.dart';
import 'package:rental_finance_tracker/features/expense/presentation/new_expense_view.dart';
import 'package:rental_finance_tracker/features/home/presentation/home_page_view.dart';

import 'features/settings/settings.dart';
import 'main.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) => const MainScaffold(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/newBookings',
        name: 'newBookings',
        builder: (context, state) => const NewBooking(),
      ),
      GoRoute(
        path: '/newExpense',
        name: 'newExpense',
        builder: (context, state) => const NewExpense(),
      ),
      GoRoute(
        path: '/bookings',
        name: 'bookings',
        builder: (context, state) => const BookingsPage(),
      ),
    ],
  );
});
