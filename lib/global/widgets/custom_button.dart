import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';
import 'package:rental_finance_tracker/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final Color? buttonColor;
  final bool isFullWidth;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.buttonColor,
    this.isFullWidth = false,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child:
            isLoading
                ? Container(
                  width: isFullWidth ? double.infinity : size.width * 0.5,
                  height: size.width * 0.1,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    gradient: LinearGradient(
                      colors: [
                        lighten(theme.primaryColor, 0.2),
                        darken(theme.primaryColor, 0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(AppConstants.buttonLoading),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                : Container(
                  width: isFullWidth ? double.infinity : size.width * 0.5,
                  height: size.width * 0.1,
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
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
      ),
    );
  }
}
