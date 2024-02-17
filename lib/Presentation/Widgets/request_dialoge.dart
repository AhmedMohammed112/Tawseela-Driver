import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela_driver/App/Push_Notification/notifications.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';

import '../Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_cubit.dart';
import '../Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_states.dart';
import 'line.dart';

void requestDialog(BuildContext context, RideRequestData rideRequestData, String rideRequestId)
{
    BuildContext cont = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: MyText(text: "New Ride Request",size: AppSizes.s25, style: Theme.of(context).textTheme.displayLarge!,)),
          content: SizedBox(
            height: AppSizes.s500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/side_car.png",height: AppSizes.s200,width: AppSizes.s300,),
                  const Line(),
                  const SizedBox(height: AppSizes.s10,),
                  Row(
                    children: [
                      const Expanded(flex:1,child: Icon(Icons.location_on,color: Colors.blue,)),
                      const SizedBox(width: AppSizes.s10,),
                      Expanded(flex: AppSizes.s6.toInt(), child: MyText(text: rideRequestData.originAddress ,size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s20,),
                  Row(
                    children: [
                      Expanded(flex: AppSizes.s1.toInt(),child: const Icon(Icons.location_on,color: Colors.red,)),
                      const SizedBox(width: AppSizes.s10,),
                      Expanded(flex: AppSizes.s6.toInt(),child: MyText(text: rideRequestData.destinationAddress ,size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s10,),
                  const Line(),
                  const SizedBox(height: AppSizes.s10,),
                  Row(
                    children: [
                      Expanded(flex: AppSizes.s1.toInt(),child: const Icon(Icons.person,color: Colors.blue,)),
                      const SizedBox(width: AppSizes.s10,),
                      Expanded(flex: AppSizes.s6.toInt(),child: MyText(text: rideRequestData.userName ,size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s20,),
                  Row(
                    children: [
                      Expanded(flex: AppSizes.s1.toInt(),child: const Icon(Icons.phone,color: Colors.red,)),
                      const SizedBox(width: AppSizes.s10,),
                      Expanded(flex: AppSizes.s6.toInt(),child: MyText(text: rideRequestData.userPhone ,size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            BlocBuilder<HomeCubit,HomeStates>(
              builder: (context,state) {
                var cubit = HomeCubit.get(context);
                return TextButton(
                  onPressed: () async {
                    cubit.acceptRideRequest(rideRequestId, cont, cubit.currentUserData!, rideRequestData);
                    Navigator.of(context).pop();
                  },
                  child: MyText(text: "Accept",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: MyText(text: "Reject",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
            ),
          ],

        );
      }
  );
}

