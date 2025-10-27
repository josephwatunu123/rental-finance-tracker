import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/features/create_booking/new_booking_view_model.dart';
import 'package:rental_finance_tracker/features/create_booking/new_bookings_state.dart';
import 'package:rental_finance_tracker/global/widgets/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewBooking extends ConsumerStatefulWidget {
  const NewBooking({super.key});

  @override
  ConsumerState<NewBooking> createState() => _NewBookingState();
}
DateTimeRange dateTimeRange = DateTimeRange(
    start:AppConstants.today,
    end: AppConstants.tomorrow
);
final startDate = dateTimeRange.start;
final endDate = dateTimeRange.end;

class _NewBookingState extends ConsumerState<NewBooking> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final viewModel = ref.watch(newBookingViewModelProvider.notifier);
    final state = ref.watch(newBookingViewModelProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            TitleBar(
              title: 'New Booking',
              subtitle: 'Add a new booking.',
              icon: FontAwesomeIcons.hotel,
              customHeight: size.height * 0.17,
              isAppBar: true,
              newBorderRadius: 20,
              gradientColors: [
                theme.primaryColor.withAlpha(300),
                theme.primaryColor.withAlpha(800),
              ],
            ),
            CustomInputField(
                label: 'Name',
                controller: viewModel.nameController,
              errorText: state.nameErrMessage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 20,
              children: [
                // DatePickerButton(
                //   givenDate: 'From: ${formatDate(state.from)}',
                //   onTap: ()=>pickDateRange(state: state),
                // ),
                // DatePickerButton(
                //   givenDate: 'To: ${formatDate(state.to)}',
                //   onTap: ()=>pickDateRange(state: state),
                // ),
              ],
            ),
            CustomInputField(
                controller: viewModel.amountController,
                label: 'Amount',
                inputType: TextInputType.number,
                errorText: state.amountErrMessage,
            ),
            CustomDropDown(
              selectedValue: state.paymentMethod,
              hint: 'Payment Method',
              isFullWidth: true,
              items: AppConstants.paymentMethods,
              onChanged: viewModel.onPaymentMethodChanged,
            ),
            CustomInputField(
                label: 'Payment Reference',
                controller: viewModel.paymentRefController,
                errorText: state.paymentRefErrMsg,
            ),
            CustomDropDown(
              selectedValue: state.bookingSource,
              hint: 'Booking Source',
              isFullWidth: true,
              items: AppConstants.bookingSources,
              onChanged: viewModel.onBookingSrcChanged,
            ),
            CustomDropDown(
              selectedValue: state.bookingStatus,
              hint: 'Booking Status',
              isFullWidth: true,
              items: AppConstants.bookingStatus,
              onChanged: viewModel.onBookingStatusChanged,
            ),
            CustomInputField(
                label: 'Additional Notes',
                controller: viewModel.notesController,
            ),
            CustomInputField(
                label: 'Reminder',
                controller: viewModel.reminderController,
            ),
            CustomButton(title: 'Create Booking',
              isLoading: state.isLoading,
              onTap: viewModel.onCreateNewBooking
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateRange({required NewBookingsState state}) async {
    final viewModel = ref.read(newBookingViewModelProvider.notifier);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Date Range"),
          content: SizedBox(
            height: 300,
            width: 400,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                state.from ?? startDate,
                state.to ?? endDate,
              ),
              onSelectionChanged: (args) {
                if (args.value is PickerDateRange) {
                  final range = args.value as PickerDateRange;
                  final from = range.startDate ?? startDate;
                  final to = range.endDate ?? endDate;
                  viewModel.updateDateRange(from, to);
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }
}
