
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_text.dart';
import 'my_container.dart';

class MyTextButton extends StatelessWidget {

      Function fun;
      String textButton;
      Color buttonColor;
      Color textColor = Colors.white;
      double width = double.infinity;
      double size = 20;
      double widthButton = double.infinity;
      double heightButton = 50;
      double radius;

   MyTextButton({Key? key, required this.fun, required this.textButton, this.buttonColor = Colors.grey, this.textColor = Colors.black ,this.width = double.infinity, this.size = 20,this.widthButton = double.infinity,this.heightButton = 50,this.radius = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      height: heightButton,
      width: widthButton,
      color: buttonColor,
      radius: radius,
      child: TextButton(
          onPressed: () {
            fun();
            },
          child: MyText(
            text: textButton,
              size: size,
            style: Theme.of(context).textTheme.displayLarge!,

          ),
      ),
    );
  }
}
