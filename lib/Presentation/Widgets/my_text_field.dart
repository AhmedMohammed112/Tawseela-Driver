
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';
import 'my_container.dart';

class MyTextFormField extends StatelessWidget {
  var controller;
  Function(String) validator;
  Function(String value)? myOnFieldSubmitted;
  Function(String value)? myOnChanged;
  Function()? onCompleted;
  Function()? onTap;
  FocusNode? focusNode;
  Icon? prefixIcon;
  Widget? suffixIcon;
  String? labelText;
  String? hintText;
  bool secureText = false;
  var type = TextInputType.text;
  double height = 70;
  int maxLine = 1;
  bool outLineBorder = true;
  Color color = Colors.white;
  double radius;
  Color borderColor = Colors.grey;


  MyTextFormField({
    required this.controller,
    required this.validator,
     this.myOnChanged,
     this.myOnFieldSubmitted,
      this.onCompleted,
      this.onTap,
      this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.secureText = false,
    this.type = TextInputType.text,
    this.height = 70,
    this.maxLine = 1,
    this.outLineBorder = true,
    this.color = Colors.white70,
    this.radius = 30,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (String? value) => validator(value!),
      onChanged: myOnChanged,
      onFieldSubmitted: myOnFieldSubmitted,
      onEditingComplete: () => onCompleted!(),
      onTap: onTap,
      focusNode: focusNode,
      obscureText: secureText,
      keyboardType: type,
      maxLines: maxLine,
      style: Theme.of(context).textTheme.displayLarge!,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: ColorManager.grey.withAlpha(30),
        filled: true,
        labelText: labelText,
        hintText: hintText,
        border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      ),
    );
  }
}
