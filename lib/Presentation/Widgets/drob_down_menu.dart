import 'package:flutter/material.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';

import 'my_container.dart';
import 'my_text.dart';

class DrobDownMenu extends StatelessWidget {
  final String hint;
  final void Function(String?)? onChanged;
  final List<String> items;


  const DrobDownMenu({super.key, required this.hint, required this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyContainer( 
      height: size.height * 0.05,
      width: size.width * 0.3,
      radius: AppSizes.s10,
      child: DropdownButtonFormField<String>(
          value: null,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MyText(text: hint),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
        decoration: const InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        )
      ),
    );
  }
}
