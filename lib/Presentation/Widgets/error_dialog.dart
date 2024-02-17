import 'package:flutter/Material.dart';

import '../Resources/values_manager.dart';
import 'my_text.dart';

void warningDialog(BuildContext context) {
  print("Warning Dialog");
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: MyText(
          text: "Not allowed",
          size: AppSizes.s15,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
        content: MyText(
          text: "You have already accepted a ride request",
          size: AppSizes.s15,
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: MyText(
                text: "OK",
                size: AppSizes.s15,
                style: Theme.of(context).textTheme.labelMedium!,
              ))
        ],
      ));
}