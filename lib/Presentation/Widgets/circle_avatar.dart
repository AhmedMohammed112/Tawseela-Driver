import 'package:flutter/Material.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';

class MyCircleAvatar extends StatelessWidget {

  double radius = AppSizes.s30;
  Widget child = const Placeholder();
  Color? color;

  MyCircleAvatar({Key? key,this.radius = AppSizes.s30,required this.child, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
        );
  }
}
