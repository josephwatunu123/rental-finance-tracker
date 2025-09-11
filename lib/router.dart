import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_finance_tracker/features/booking/presentation/new_booking.dart';

import 'features/home/presentation/home_page.dart';
import 'features/settings/settings.dart';


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
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
    ],
  );
});
