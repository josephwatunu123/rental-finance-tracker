import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';

class DatePickerButton extends StatefulWidget {
  final bool isFullWidth;
  final Function(DateTime? pickedDate) onDateChanged;
  final String? selectedDate;
  final Set<DateTime>? bookedDays;
  const DatePickerButton({
    super.key,
    this.isFullWidth = false,
    required this.selectedDate,
    required this.onDateChanged,
    this.bookedDays,
  });

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _selectDate(context: context, bookedDays: widget.bookedDays),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: size.height * 0.06,
        width: widget.isFullWidth ? double.infinity : size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: theme.primaryColor),
        ),
        child: Row(
          mainAxisAlignment:
              widget.isFullWidth
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: theme.primaryColor,
              size: 25,
            ),
            Text(
              widget.selectedDate ?? "select date",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate({
    required BuildContext context,
    Set<DateTime>? bookedDays,
  }) async {
    final Set<DateTime> normalizedBookedDays =
        bookedDays?.map((d) {
          return DateTime(d.year, d.month, d.day);
        }).toSet() ??
        {};

    DateTime findValidInitialDate() {
      final today = DateTime.now();
      DateTime candidate = DateTime(today.year, today.month, today.day);
      for (int i = 0; i < 365; i++) {
        if (!normalizedBookedDays.contains(candidate)) {
          return candidate;
        }
        candidate = candidate.add(const Duration(days: 1));
      }
      return today;
    }

    final DateTime validInitialDate = findValidInitialDate();

    bool isDaySelectable(DateTime day) {
      final normalized = DateTime(day.year, day.month, day.day);
      return !normalizedBookedDays.contains(normalized);
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      selectableDayPredicate: isDaySelectable,
    );

    if (pickedDate != null) {
      widget.onDateChanged(pickedDate);
    }
  }
}
