import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/features/booking/bookings_view_model.dart';

class BookingsPage extends ConsumerStatefulWidget {
  const BookingsPage({super.key});

  @override
  ConsumerState<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends ConsumerState<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    final size = MediaQuery.of(context).size;
    final state = ref.watch(bookingsPageViewModelProvider);
    return Scaffold(
      body: Center(
        child: state.error !=null ? Text('${state.error}')
            : state.isLoading ? Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppConstants.bookingsLoadingGif),
            ),
          ),
        )
            : RefreshIndicator(
                onRefresh: () async {

                },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(

              ),
            ),
        )
      ),
    );
  }
}
