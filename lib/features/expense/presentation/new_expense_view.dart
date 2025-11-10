import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/features/expense/new_expense_view_model.dart';
import 'package:rental_finance_tracker/global/widgets/date_picker.dart';
import 'package:rental_finance_tracker/global/widgets/text_fields.dart';
import 'package:rental_finance_tracker/global/widgets/custom_button.dart';
import 'package:rental_finance_tracker/global/widgets/custom_drop_down.dart';
import 'package:rental_finance_tracker/global/widgets/title_bar.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';
import 'package:rental_finance_tracker/utils/functions.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key});

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  DateTime expensePaymentDate = AppConstants.today;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewModel = ref.watch(newExpenseViewModelProvider.notifier);
    final state = ref.watch(newExpenseViewModelProvider);
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
            const SizedBox(height: 10),
            CustomInputField(
              label: 'Expense Title',
              controller: viewModel.expenseNameController,
              errorText: state.expenseTitleErrMsg,
            ),
            CustomDropDown(
              hint: 'Expense Type',
              isFullWidth: true,
              items: AppConstants.expenseTypes,
              onChanged: viewModel.onExpenseTypeChanged,
              errorText: state.expenseTypeErrMsg,
            ),
            CustomDropDown(
              hint: 'Payment Method',
              isFullWidth: true,
              items: AppConstants.paymentMethods,
              onChanged: viewModel.onPaymentMethodChanged,
              errorText: state.paymentMethErrMsg,
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
                    onDateChanged: viewModel.onSelectPaymentDate,
                    selectedDate:
                        formatDate(state.expensePaymentDate) ?? 'select date',
                  ),
                ],
              ),
            ),
            CustomInputField(
              label: 'Amount',
              inputType: TextInputType.number,
              controller: viewModel.amountController,
              errorText: state.amountErrMsg,
            ),
            CustomInputField(
              label: 'Payment Reference',
              controller: viewModel.paymentRefController,
              errorText: state.paymentRefErrMsg,
            ),
            CustomInputField(
              label: 'Additional Notes',
              controller: viewModel.notesController,
            ),
            CustomInputField(
              label: 'Reminder',
              controller: viewModel.reminderController,
            ),
            CustomButton(
              isLoading: state.isLoading,
              title: 'Create Expense',
              isFullWidth: true,
              onTap: viewModel.onCreateNewExpense,
            ),
          ],
        ),
      ),
    );
  }
}
