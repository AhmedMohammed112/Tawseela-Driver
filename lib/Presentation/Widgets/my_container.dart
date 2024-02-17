import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double radius;
  final Widget child;
  final Color color;
  final double width;
  final double height;
  final double padding;
  final double innerPadding;
  final double margin;
  final bool border;


   const MyContainer({
    Key? key,
    required this.radius,
    required this.child,
    this.color = Colors.white,
    this.width = double.infinity,
    this.height = 50,
    this.padding = 0,
    this.innerPadding = 0,
    this.margin = 0,
     this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(padding),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: border ? Border.all(color: Colors.grey) : const Border(),
          color: color,
        ),
        child: Padding(
          padding: EdgeInsets.all(innerPadding),
          child: child,
        )
    );
  }
}
