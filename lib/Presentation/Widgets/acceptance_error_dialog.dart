import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import 'package:twseela_driver/Domain/Models/user_data.dart';

import '../Resources/values_manager.dart';
import '../Screens/Home_Screen/Bottom_Nav_Bar_Screens/Map_Screen/Map_Cubit/home_cubit.dart';
import '../Screens/Home_Screen/Bottom_Nav_Bar_Screens/Map_Screen/Map_Cubit/home_states.dart';
import 'line.dart';
import 'my_elevation_button.dart';
import 'my_text.dart';

void acceptanceErrorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: MyText(text: "Warning",size: AppSizes.s15,style: Theme.of(context).textTheme.displayLarge!,),
        content: MyText(text: "This ride request has been accepted by another driver",size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium!,),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: MyText(text: "OK",size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium!,)
          )
        ],
      )
  );
}

void acceptedUserModalBottomSheet(BuildContext context,UserData user) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context, builder: (context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(text: "Destination details",style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
            const Line(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.s20),
                    ),
                    child: Center(
                      child: Image.network(user.image),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: MyText(text: user.name!,style: Theme.of(context).textTheme.displayLarge!,size: 20,)),
                          Expanded(child: IconButton(
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber(user.phone);
                            },
                            icon: const Icon(Icons.call),color: Colors.green,))
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),


          ],
        ),
      ),
    );
  });
}