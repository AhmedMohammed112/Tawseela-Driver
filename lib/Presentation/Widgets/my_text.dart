

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  double size = 14;
  final bool bold = false;
  final Color color = Colors.black;
  int lines = 99;
  final TextStyle style;

  MyText({super.key, required this.text, this.size = 14,this.lines = 99, this.style = const TextStyle() });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        fontSize: size,
        overflow: TextOverflow.ellipsis,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: lines,

    );
  }
}
