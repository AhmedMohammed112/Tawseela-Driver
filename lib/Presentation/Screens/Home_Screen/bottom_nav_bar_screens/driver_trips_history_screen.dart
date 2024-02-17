import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';

import '../../../Widgets/my_elevation_button.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_states.dart';

class DriverTripsHistory extends StatelessWidget {
  const DriverTripsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHistoryTripsCubit,DriverHistoryTripsStates>(
      listener: (BuildContext context, state) {
        // if(state is GetDriverHistoryTripsErrorState) {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: MyText(
        //       text: state.failure.message!,
        //       size: AppSizes.s16,
        //     ),
        //   ));
        // }
      },
      builder: (BuildContext context, state) {
        var cubit = DriverHistoryTripsCubit.get(context);
        return (state is GetDriverHistoryTripsErrorState) ?
        Center(
          child: Container(
            height: AppSizes.s200,
            width: AppSizes.s200,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(AppSizes.s20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: AppSizes.s5,
                  blurRadius: AppSizes.s6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: state.failure.message!,
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
                const SizedBox(height: AppSizes.s20,),
                MyElevationButton(
                  widthButton: AppSizes.s100,
                  fun: () {
                    cubit.getDriverTripsHistory();
                  },
                  textButton: "Retry",
                ),
              ],
            ),
          ),
        )
            :
        state is GetDriverHistoryTripsSuccessState ? Padding(
          padding: const EdgeInsets.all(AppSizes.s15),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.s20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(text: 'From: ${cubit.driverHistoryTrips[index].originAddress}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      MyText(text: 'To: ${cubit.driverHistoryTrips[index].destinationAddress}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      MyText(text: 'Date: ${cubit.driverHistoryTrips[index].date.substring(0,10)}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      MyText(text: 'Time: ${cubit.driverHistoryTrips[index].date.substring(11,19)}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      MyText(text: 'Price: ${cubit.driverHistoryTrips[index].fareAmount}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      MyText(text: 'Status: ${cubit.driverHistoryTrips[index].tripStatus}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                      Row(
                        children: [
                          MyText(text: 'Rating: ${cubit.driverHistoryTrips[index].rating}',style: Theme.of(context).textTheme.labelMedium!,size: AppSizes.s15,),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: cubit.driverHistoryTrips.length,
          ),
        ) : const CircularProgressIndicator();
      },
    );
  }
}
