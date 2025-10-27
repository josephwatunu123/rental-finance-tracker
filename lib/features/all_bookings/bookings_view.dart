import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/features/all_bookings/widgets/bookings_list.dart';
import 'package:rental_finance_tracker/features/all_bookings/bookings_view_model.dart';
import 'package:rental_finance_tracker/global/widgets/date_picker.dart';
import 'package:rental_finance_tracker/global/widgets/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

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
    final viewModel = ref.watch(bookingsPageViewModelProvider.notifier);
    final state = ref.watch(bookingsPageViewModelProvider);
    return Scaffold(
      body: state.error !=null ? Text('${state.error}')
          : state.isLoading ? Center(
            child: Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppConstants.bookingsLoadingGif),
            ),
                    ),
                  ),
          )
          : RefreshIndicator(
              onRefresh: () async {

              },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              spacing: 10,
              children: [
                TitleBar(
                    isAppBar: true,
                    icon: FontAwesomeIcons.bed,
                  subtitle: 'A list of all your bookings',
                  customHeight: size.height * 0.17,
                    title: 'Bookings',
                  gradientColors: [
                    lighten(theme.primaryColor, 0.2),
                    darken(theme.primaryColor, 0.2),
                  ],
                ),
                CustomInputField(
                  hintText: 'Search Client Name',
                  maxLines: 1,
                  prefixIcon: Icon(Icons.search),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatePickerButton(
                      selectedDate: (formatDate(state.startDate) ?? 'select date'),
                        onDateChanged: viewModel.onStartDateChanged,
                    ),
                    DatePickerButton(
                      selectedDate: (formatDate(state.endDate) ?? 'select date'),
                      onDateChanged: viewModel.onEndDateChanged,
                    ),
                    Icon(FontAwesomeIcons.filePdf)
                  ],
                ),
                BookingsList(bookings: state.bookings)
              ],
            ),
          ),
      ),
    );
  }
}
