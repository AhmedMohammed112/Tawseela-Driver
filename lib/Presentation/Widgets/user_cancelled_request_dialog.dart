import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Resources/values_manager.dart';
import '../Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_cubit.dart';
import '../Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_states.dart';
import 'my_text.dart';

void userCancelledRequestDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: MyText(
          text: "Warning",
          size: AppSizes.s15,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
        content: MyText(
          text: "This ride request has been cancelled by the user",
          size: AppSizes.s15,
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        actions: [
          BlocBuilder<HomeCubit,HomeStates>(
            builder: (context,state) {
              var cubit = HomeCubit.get(context);
              cubit.cancelTripByUser();
              return TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: MyText(text: "OK",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
              );
            },
          ),
        ],
      ));
}