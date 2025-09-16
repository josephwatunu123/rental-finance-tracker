import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/constants/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime(2025,08,01),
      end: DateTime(2025,09,01));
  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 20,
            children: [
              const SizedBox(height: 30,),
              TitleBar(
                title: "New Expense",
                icon: Icons.credit_card_outlined,
                subtitle: 'Add new expense.',
              ),
              CustomDropDown(
                  hint: 'Expense Type',
                  isFullWidth: true,
                  items: expenseTypes,
                  onChanged: (val){}
              ),
              CustomDropDown(
                  hint: 'Payment Method',
                  isFullWidth: true,
                  items: paymentMethods,
                  onChanged: (val){}
              ),
              CustomInputField(
                label: 'Amount',
                inputType: TextInputType.number,

              ),
              CustomInputField(
                label: 'Payment Reference',

              ),
              CustomInputField(
                label: 'Additional Notes',

              ),
              CustomInputField(
                label: 'Reminder',

              ),
              CustomButton(title: 'Create Expense', onTap: (){},)
            ],
          ),
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
