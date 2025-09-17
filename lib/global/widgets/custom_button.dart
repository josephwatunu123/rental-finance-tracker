import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final Color? buttonColor;
  const CustomButton({super.key, required this.title, required this.onTap, this.buttonColor});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width *0.5,
          height: size.width *0.1,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighten(theme.primaryColor, 0.2),
                darken(theme.primaryColor, 0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),),
        ),
      ),
    );
  }
}
