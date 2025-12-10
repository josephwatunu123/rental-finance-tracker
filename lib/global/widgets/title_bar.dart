import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';

class TitleBar extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final double? borderWidth;
  final double? newBorderRadius;
  final bool hasBorders;
  final double? customHeight;
  final bool isAppBar;
  final DateTime? selectedMonth;
  final Function(DateTime?)? dropdownFilter;
  const TitleBar({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.gradientColors,
    this.newBorderRadius,
    this.hasBorders = false,
    this.borderWidth,
    this.customHeight,
    this.isAppBar = false,
    this.dropdownFilter,
    this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      alignment: (isAppBar) ? Alignment.bottomLeft : Alignment.centerLeft,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      height: (customHeight != null) ? customHeight : size.height * 0.1,
      decoration: BoxDecoration(
        color: backgroundColor?.withAlpha(300),
        gradient:
            (gradientColors != null)
                ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        borderRadius: BorderRadius.all(Radius.circular(newBorderRadius ?? 20)),
        border: hasBorders ? Border.all(width: borderWidth ?? 0.01) : null,
      ),
      child: Column(
        mainAxisAlignment:
            isAppBar ? MainAxisAlignment.end : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Icon(icon),
              Text(
                title ?? "--",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          dropdownFilter != null
              ? PopupMenuButton<DateTime>(
                onSelected:
                    (selectedMonth) => dropdownFilter?.call(selectedMonth),
                itemBuilder: (context) {
                  return AppConstants.months.map((month) {
                    return PopupMenuItem<DateTime>(
                      value: month,
                      child: Text(DateFormat.MMMM().format(month)),
                    );
                  }).toList();
                },
                child: Row(
                  children: [
                    Text(
                      selectedMonth != null
                          ? ('${DateFormat.MMMM().format(selectedMonth!).toUpperCase()} STATISTICS')
                          : "Select month",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Transform.rotate(
                      angle: math.pi / 2,
                      child: const Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
              : Text(
                subtitle ?? "",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
        ],
      ),
    );
  }
}
