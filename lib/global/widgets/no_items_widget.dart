import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoItemsWidget extends StatelessWidget {
  final String? itemName;
  const NoItemsWidget({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.3,
        width: size.width * 0.5,
        child: Column(
          children: [
            Lottie.asset('assets/lottie/no-items.json'),
            Text(
              'No ${itemName ?? 'Data'} Found',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
