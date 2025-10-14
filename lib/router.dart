import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/booking/presentation/new_booking.dart';
import 'package:rental_finance_tracker/features/expenses/presentation/new_expense.dart';
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
    ],
  );
});
