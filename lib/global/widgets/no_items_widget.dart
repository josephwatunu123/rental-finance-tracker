import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: AssetImage(AppConstants.noItemsImage)),
          Text('No bookings', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
