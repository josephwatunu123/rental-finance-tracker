import 'package:flutter/material.dart';

class DatePickerButton extends StatelessWidget {
  final bool isFullWidth;
  final GestureTapCallback onTap;
  final String? givenDate;
  const DatePickerButton({
    super.key,
    this.isFullWidth=false,
    required this.givenDate,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: size.height * 0.06,
        width: isFullWidth ? double.infinity : size.width *0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: theme.primaryColor
          )
        ),
        child: Row(
          mainAxisAlignment: isFullWidth ? MainAxisAlignment.center :MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: theme.primaryColor,
              size: 25,
            ),
            Text(givenDate ?? "select date",style: theme.textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
