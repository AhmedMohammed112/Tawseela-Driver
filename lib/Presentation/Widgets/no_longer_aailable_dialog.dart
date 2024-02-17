import 'package:flutter/Material.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';

void dialogNoLongerAvailable(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyText( text: "Error", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
          content: MyText( text: "This request is no longer available", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
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