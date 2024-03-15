import 'package:flutter/Material.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import 'package:twseela_driver/Presentation/Widgets/rate_bar.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

class RatingCard extends StatelessWidget { 
  final RideRequestData tripData;
  const RatingCard({super.key, required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                text:
                "Trip date: ${tripData.date}", style:
            Theme.of(context).textTheme.labelMedium!
            ),
            Row(
              children: [
                MyText(
                    text:
                    "Rate: ${tripData.rating}", style:
                Theme.of(context).textTheme.labelMedium!
                ),
                const SizedBox(width: AppSizes.s10,),
                RateBar(rate: tripData.rating!.toInt()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
