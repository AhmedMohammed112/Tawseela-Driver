import 'package:flutter/Material.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

class TripHistoryCard extends StatelessWidget { 
  final RideRequestData tripData;
  const TripHistoryCard({super.key, required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(AppSizes.s20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            MyText(
              text:
              "From: ${tripData.originAddress}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "To: ${tripData.destinationAddress}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "Date: ${tripData.date.substring(0, 10)}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "Time: ${tripData.date.substring(11, 16)}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "Rating: ${tripData.tripStatus}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "Status: ${tripData.rating}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s5,
            ),
            MyText(
              text:
              "Fare: ${tripData.fareAmount} \$",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
