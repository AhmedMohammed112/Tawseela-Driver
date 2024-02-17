import 'package:flutter/Material.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';

class SummaryRow extends StatelessWidget {
  String first;
  String second;
  VoidCallback fun;
  SummaryRow({Key? key,required this.first,required this.second,required this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p8,left: AppPadding.p8,bottom: AppPadding.p8,top: AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyText(
            text: "$first",
            size: 20,
            style: Theme.of(context).textTheme.displayLarge!,
          ),
          const Spacer(),
          InkWell(
            onTap: fun,
            child: Row(
              children: [
                MyText(
                  text: "$second",
                  size: 15,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
