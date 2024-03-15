import 'package:flutter/Material.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

class TotalEarningCard extends StatelessWidget {
  final double totalEarning;
  const TotalEarningCard({super.key, required this.totalEarning});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            MyText(
              text:
              "Total Earning: ${totalEarning.toStringAsFixed(2)} \$", size: AppSizes.s25,
              style: Theme.of(context).textTheme.displayLarge!,
            ),
          ],
        ),
      ),
    );
  }
}
