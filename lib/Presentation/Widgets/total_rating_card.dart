import 'package:flutter/Material.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

class TotalRatingCard extends StatelessWidget {
  final double totalRating;
  const TotalRatingCard({super.key, required this.totalRating});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText(
              text:
              "Total Rating: ${totalRating.toStringAsFixed(1)} ",
              style: Theme.of(context).textTheme.displayLarge!,
            ),
            const SizedBox(height: AppSizes.s10,),
            const Icon(Icons.star,color: Colors.amber,size: AppSizes.s40,)
          ],
        ),
      ),
    );
  }
}
