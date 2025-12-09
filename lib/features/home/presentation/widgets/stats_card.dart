import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';

class StatsCard extends StatelessWidget {
  final IconData mainIcon;
  final String title;
  final int? total;
  final int? statistic;
  final bool addCurrency;
  final bool isLoading;
  final Color? textColor;
  const StatsCard({
    super.key,
    required this.mainIcon,
    required this.title,
    required this.total,
    this.statistic,
    this.addCurrency = true,
    this.isLoading = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      height: size.height * 0.12,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: theme.primaryColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isLoading)
                Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppConstants.dotsLoadingGif),
                    ),
                  ),
                )
              else
                Text(
                  addCurrency ? 'Kes. ${total ?? 0}' : '${total ?? 0}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

              FaIcon(mainIcon, color: theme.primaryColor),
            ],
          ),

          Text(
            '+${statistic ?? 0}%',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
