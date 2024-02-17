import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela_driver/App/Push_Notification/notifications.dart';
import 'package:twseela_driver/Presentation/Resources/color_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_elevation_button.dart';

import '../../../../Resources/values_manager.dart';
import '../../../../Widgets/line.dart';
import '../../../../Widgets/my_text.dart';
import 'Map_Cubit/home_cubit.dart';
import 'Map_Cubit/home_states.dart';


class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (BuildContext context, HomeStates state) {  },
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: GoogleMap(
                mapType: MapType.normal,
                padding: EdgeInsets.only(bottom: cubit.bottomPadding ),
                initialCameraPosition: CameraPosition(
                  target: cubit.pickUpLocation ?? const LatLng(30.033333, 31.233334),
                  zoom: 14.4746,

                ),
                onMapCreated: (GoogleMapController controller) {
                  cubit.controller = controller;
                  cubit.getDriverUpdatesAtRealTime();
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: cubit.markers,
                circles: cubit.circles,
                polylines: cubit.polyLines,
              ),
            ),
            if(cubit.isDriverOnline)
            Align(
                alignment: Alignment.topLeft,
                child:
                Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: MyElevationButton(
                          buttonColor: ColorManager.black.withOpacity(0.5),
                          widthButton: AppSizes.s330,
                          heightButton: AppSizes.s50,
                          fun: () {
                            cubit.init(context);
                            cubit.changeDriverOnlineStatus(context);
                          },
                          size: AppSizes.s15,
                          textButton: "You are ${cubit.isDriverOnline ? 'Online' : 'Offline'} Now, Click to change status",
                        ),
                      );
                    }
                )
            ),
            if(!cubit.isDriverOnline)
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(0.9),
                    ),
                  ),
                  Center(
                    child: MyElevationButton(
                        widthButton: AppSizes.s160,
                        heightButton: AppSizes.s70,
                        fun: () async {
                          await cubit.init(context);
                          cubit.changeDriverOnlineStatus(context);
                        }, textButton: 'Offline Now'),
                  ),
                ],
              ),
            if(cubit.trip != "Not assigned")
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p16),
                height: 270,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSizes.s40),topRight: Radius.circular(AppSizes.s40)),
                ),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(cubit.directionDetailsInfo != null)
                    MyText(text: "Remaining time: ${cubit.directionDetailsInfo!.durationText}",style: Theme.of(context).textTheme.displayLarge!,),
                    const SizedBox(height: AppSizes.s5,),
                    if(cubit.directionDetailsInfo != null)
                    MyText(text: "Distance: ${cubit.directionDetailsInfo!.distanceText}",style: Theme.of(context).textTheme.displayLarge!,),
                    const Line(),
                    Row(
                      children: [
                        const Icon(Icons.location_on,color: Colors.blue,),
                        const SizedBox(width: AppSizes.s10,),
                        Expanded(child: MyText(text: cubit.address!,style: Theme.of(context).textTheme.labelMedium!,)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.s10,),
                    Row(
                      children: [
                        const Icon(Icons.location_on,color: Colors.red,),
                        const SizedBox(width: AppSizes.s10,),
                        Expanded(child: MyText(text: cubit.rideRequestData!.originAddress,style: Theme.of(context).textTheme.labelMedium!,)),
                      ],
                    ),
                    const Line(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MyElevationButton(
                            fun: () {
                            if(cubit.trip == "arrived") {
                              changeTripStatus("arrived");
                              cubit.changeRequestStatus("onTrip");

                              cubit.setDestinationToDropOffLocation();
                            }
                            else if(cubit.trip == "onTrip") {
                              changeTripStatus("onTrip");
                              cubit.changeRequestStatus("show fare");
                            }
                            else if(cubit.trip == "show fare") {
                              changeTripStatus("ended");
                              cubit.endTripWithCalculateFare(context);
                            }

                          }, textButton: cubit.trip, widthButton: AppSizes.s120, heightButton: AppSizes.s50,),
                        ),
                        const SizedBox(width: AppSizes.s10,),
                        Expanded(
                          child: MyElevationButton(fun: () {
                            cubit.cancelTripByDriver();
                          }, textButton: "Cancel Trip", widthButton: AppSizes.s120, heightButton: AppSizes.s50,),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            ],
        );
      },
    );
  }
}
