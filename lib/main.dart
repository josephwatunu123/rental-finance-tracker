import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/features/home/presentation/home_page_view.dart';
import 'package:rental_finance_tracker/router.dart';
import 'package:rental_finance_tracker/theme/app_theme.dart';
import 'package:rental_finance_tracker/utils/global_keys.dart';

import 'features/all_bookings/bookings_view.dart';
import 'features/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Profit Stay',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: route,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
    );
  }
}

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _currentIndex = 0;

  final _pages = const [HomePage(), BookingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: NavigationBar(
            height:
                Platform.isIOS ? MediaQuery.of(context).size.height * 0.08 : 80,
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            backgroundColor: Colors.grey.withAlpha(50),
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.bedroom_parent),
                label: 'Bookings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
