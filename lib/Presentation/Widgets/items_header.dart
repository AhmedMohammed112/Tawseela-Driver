import 'package:flutter/material.dart';

import 'my_text.dart';

class HomeHeader extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;
  const HomeHeader({Key? key,required this.title,required this.description,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText(text: title,size: 40,style: Theme.of(context).textTheme.displayLarge!,),
            const Spacer(),
            InkWell(
              onTap: () {
                onTap();
              },
                child: MyText(text: "View All"),
            )
          ],
        ),
        MyText(text: description),
      ],
    );
  }
}
