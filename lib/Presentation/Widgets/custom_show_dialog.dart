import 'package:flutter/Material.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';



Future<Widget> customShowDialog({required BuildContext context,required String title, required dynamic content,required List<Widget> actions}) async
{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: AppSizes.s20,
          title: MyText(text: title,size: AppSizes.s20,),
          content: content,
          actions: actions,
        );
      }
  );
}

