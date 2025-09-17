import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/constants/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime(2025,08,01),
      end: DateTime(2025,09,01));
  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            TitleBar(
              title: 'New Booking',
              subtitle: 'Add a new booking.',
              icon: FontAwesomeIcons.hotel,
              customHeight: size.height *0.17,
              isAppBar: true,
              newBorderRadius: 20,
              gradientColors: [
                theme.primaryColor.withAlpha(300),
                theme.primaryColor.withAlpha(800),
              ],
            ),
            CustomInputField(
              label: 'Name',

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
              label: 'Amount',
              inputType: TextInputType.number,

            ),
            CustomDropDown(
                hint: 'Payment Method',
                isFullWidth: true,
                items: paymentMethods,
                onChanged: (val){}
            ),
            CustomInputField(
              label: 'Payment Reference',

            ),
            CustomDropDown(
                hint: 'Booking Source',
                isFullWidth: true,
                items: bookingSources,
                onChanged: (val){}
            ),
            CustomDropDown(
                hint: 'Booking Status',
                isFullWidth: true,
                items: bookingStatus,
                onChanged: (val){}
            ),
            CustomInputField(
              label: 'Additional Notes',

            ),
            CustomInputField(
              label: 'Reminder',

            ),
            CustomButton(title: 'Create Booking', onTap: (){},)
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
            )
          ],
        );
      },
    );
  }
}
