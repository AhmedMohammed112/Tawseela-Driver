import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(onPressed: ()
      {
        Navigator.pop(context);
      },
          icon: const Icon(Icons.arrow_back_ios_new,size: 30,)),
    );
  }
}
