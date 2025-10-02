import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/global/widgets/text_fields.dart';
import 'package:rental_finance_tracker/features/booking/new_booking_view_model.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewBooking extends ConsumerStatefulWidget {
  const NewBooking({super.key});

  @override
  ConsumerState<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends ConsumerState<NewBooking> {
  DateTimeRange dateTimeRange = DateTimeRange(
    start:AppConstants.today,
    end: AppConstants.tomorrow
  );
  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final viewModel = ref.watch(newBookingViewModelProvider.notifier);
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
              errorText: viewModel.nameErrMessage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Flexible(
                  child: CustomButton(
                    title: 'From: ${start.day}/${start.month}/${start.year}',
                    onTap: pickDateRange,
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    title: 'To: ${end.day}/${end.month}/${end.year}',
                    onTap: pickDateRange,
                  ),
                ),
              ],
            ),
            CustomInputField(
                controller: viewModel.amountController,
                label: 'Amount',
                inputType: TextInputType.number,
                errorText: viewModel.amountErrMessage,
            ),
            CustomDropDown(
              selectedValue: viewModel.paymentMethod,
              hint: 'Payment Method',
              isFullWidth: true,
              items: AppConstants.paymentMethods,
              onChanged: viewModel.onPaymentMethodChanged,
            ),
            CustomInputField(
                label: 'Payment Reference',
                controller: viewModel.paymentReferenceController,
                errorText: viewModel.paymentRefErrMsg,
            ),
            CustomDropDown(
              selectedValue: viewModel.bookingSource,
              hint: 'Booking Source',
              isFullWidth: true,
              items: AppConstants.bookingSources,
              onChanged: viewModel.onBookingSrcChanged,
            ),
            CustomDropDown(
              selectedValue: viewModel.bookingStatus,
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
            CustomButton(title: 'Create Booking', onTap: () {
              viewModel.onCreateNewBooking();
            }),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateRange() async {
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
                dateTimeRange.start,
                dateTimeRange.end,
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final range = args.value as PickerDateRange;
                  setState(() {
                    dateTimeRange = DateTimeRange(
                      start: range.startDate ?? dateTimeRange.start,
                      end: range.endDate ?? dateTimeRange.end,
                    );
                  });
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
