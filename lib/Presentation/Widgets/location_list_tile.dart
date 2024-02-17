import 'package:flutter/Material.dart';
import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  final String descreption;
  final VoidCallback onPress;

  const LocationListTile(
      {Key? key, required this.location, required this.onPress, required this.descreption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20)
        ),
        leading: Icon(Icons.location_pin,color: ColorManager.primary,),
        title: MyText(text: location),
        subtitle: MyText(text: descreption),
        onTap: onPress,
    );
  }
}
