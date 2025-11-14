import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        height: 70,
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        indicatorColor: theme.primaryColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: Colors.transparent,
        destinations: [
           const NavigationDestination(
            icon: Icon(FontAwesomeIcons.houseChimney),
            label: '',
          ),
          const NavigationDestination(
            icon: Icon(FontAwesomeIcons.bed),
            label: '',
          ),
        ],
      ),
    );
  }
}
