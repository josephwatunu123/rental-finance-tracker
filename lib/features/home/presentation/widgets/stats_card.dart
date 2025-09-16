import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsCard extends StatelessWidget {
  final IconData mainIcon;
  final String title;
  final int? total;
  final int? statistic;
  const StatsCard({
    super.key,
    required this.mainIcon,
    required this.title,
    required this.total,
    this.statistic
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
          border: Border.all(
              width: 0.5,
              color: Colors.grey
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kes. ${total ?? 0}',style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              FaIcon(mainIcon,
                color: Colors.blueAccent
                ,)
            ],
          ),
          Text('+${statistic ?? 0}%',style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,color: Colors.green))
        ],
      ),
    );
  }
}
