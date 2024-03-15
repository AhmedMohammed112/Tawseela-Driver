import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';

import '../../../Widgets/my_elevation_button.dart';
import '../../../Widgets/trip_card.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_states.dart';

class DriverTripsHistory extends StatelessWidget {
  const DriverTripsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHistoryTripsCubit,DriverHistoryTripsStates>(
      listener: (BuildContext context, state) {},
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
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.getDriverTripsHistory();
            },
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return TripHistoryCard(tripData: cubit.driverHistoryTrips[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: AppSizes.s10);
              },
              itemCount: cubit.driverHistoryTrips.length,
            ),
          ),
        ) : Center(child: const CircularProgressIndicator());
      },
    );
  }
}
