import 'package:flutter/Material.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

void fareAmountDialog(BuildContext context, double totalFares) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyText( text: "Trip Fare", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
          content: MyText( text: "Total fare for this trip is: $totalFares", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: MyText(text: "OK", size: AppSizes.s15, style: Theme.of(context).textTheme.displayLarge!),
            ),
          ],
        );
      }
  );
}