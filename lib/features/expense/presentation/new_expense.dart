import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/global/widgets/date_picker.dart';
import 'package:rental_finance_tracker/global/widgets/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';
import 'package:rental_finance_tracker/utils/functions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime expensePaymentDate = DateTime(2025, 08, 01);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            TitleBar(
              title: 'New Expense',
              subtitle: 'Add a new expense.',
              icon: FontAwesomeIcons.hotel,
              customHeight: size.height * 0.17,
              isAppBar: true,
              newBorderRadius: 20,
              gradientColors: [
                lighten(theme.primaryColor, 0.2),
                darken(theme.primaryColor, 0.2),
              ],
            ),
            const SizedBox(height: 10,),
            CustomInputField(label: 'Expense Title'),
            CustomDropDown(
              hint: 'Expense Type',
              isFullWidth: true,
              items: AppConstants.expenseTypes,
              onChanged: (val) {},
            ),
            CustomDropDown(
              hint: 'Payment Method',
              isFullWidth: true,
              items: AppConstants.paymentMethods,
              onChanged: (val) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('Select Payment Date'),
                  DatePickerButton(
                      isFullWidth: true,
                      givenDate: '${formatDate(expensePaymentDate)}',
                      onTap: ()=> pickDateRange()
                  ),
                ],
              ),
            ),
            CustomInputField(label: 'Amount', inputType: TextInputType.number),
            CustomInputField(label: 'Payment Reference'),
            CustomInputField(label: 'Additional Notes'),
            CustomInputField(label: 'Reminder'),
            CustomButton(
                title: 'Create Expense',
                isFullWidth: true,
                onTap: () {}),
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
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: expensePaymentDate,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  final date = args.value as DateTime;
                  setState(() {
                    expensePaymentDate=date;
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
