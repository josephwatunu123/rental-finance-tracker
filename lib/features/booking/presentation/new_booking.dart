import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/text_fields.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInputField(
              label: 'Name',

            ),
            SfDateRangePicker(

            ),
            CustomInputField(
              label: 'Reminder',

            ),
            CustomInputField(
              label: 'Amount',
              inputType: TextInputType.number,

            ),
          ],
        ),
      ),
    );
  }
}
