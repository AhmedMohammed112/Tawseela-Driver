import 'package:flutter/Material.dart';

import '../Resources/values_manager.dart';
import 'my_elevation_button.dart';
import 'my_text.dart';

class NoInternetBox extends StatelessWidget {
  final String message;
  final Function fun;
  const NoInternetBox({super.key,required this.message,required this.fun});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSizes.s200,
        width: AppSizes.s200,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(AppSizes.s20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: AppSizes.s5,
              blurRadius: AppSizes.s5,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: message,
              size: AppSizes.s20,
              style: Theme.of(context).textTheme.labelMedium!,
            ),
            const SizedBox(
              height: AppSizes.s20,
            ),
            MyElevationButton(
              widthButton: AppSizes.s100,
              fun: () {
                fun();
              },
              textButton: "Retry",
            ),
          ],
        ),
      ),
    );
  }
}
