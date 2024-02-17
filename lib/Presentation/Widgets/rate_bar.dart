import 'package:flutter/material.dart';

class RateBar extends StatelessWidget {
  int rate;
  final double size;
  RateBar({Key? key,required this.rate, this.size = 20}) : super(key: key);
  Widget rateBar() {
    rate = (rate).round();
    List<Widget> stars = [];
    for(int i = 0; i < rate; i++) {
      stars.add( Icon(Icons.star,color: Colors.amber,size: size,));
    }
    if(rate < 5) {
      for(int i = rate; i < 5; i++) {
        stars.add( Icon(Icons.star_border,color: Colors.grey,size: size,));
      }
    }
    return Row(children: stars);
  }
  @override
  Widget build(BuildContext context) {
    return rateBar();
  }
}
