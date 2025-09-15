import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';

class TitleBar extends StatelessWidget {
  final IconData? icon;
  final String?title;
  final String? subtitle;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final double? borderWidth;
  final double? newBorderRadius;
  final bool hasBorders;
  const TitleBar({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.gradientColors,
    this.newBorderRadius,
    this.hasBorders=false,
    this.borderWidth
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: backgroundColor?.withAlpha(300),
        borderRadius: BorderRadius.all(
            Radius.circular(
                newBorderRadius ?? 12
            )
        ),
       border: hasBorders ? Border.all(
         width: borderWidth ?? 0.01
       ) : null

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Icon(icon),
              Text(title ?? "--", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),),
            ],
          ),
          Text(subtitle ?? "", style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}
