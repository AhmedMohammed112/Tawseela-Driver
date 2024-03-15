import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';
import 'package:twseela_driver/Presentation/Widgets/no_internet_box.dart';
import 'package:twseela_driver/Presentation/Widgets/rating_card.dart';
import 'package:twseela_driver/Presentation/Widgets/total_earning_card.dart';
import 'package:twseela_driver/Presentation/Widgets/total_rating_card.dart';
import '../../../Widgets/line.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import '../../Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_states.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHistoryTripsCubit, DriverHistoryTripsStates>(
      listener: (BuildContext context, state) {},

      builder: (BuildContext context, state) {
        var cubit = DriverHistoryTripsCubit.get(context);
        return (state is GetDriverHistoryTripsErrorState) ?
        NoInternetBox(message: state.failure.message!, fun: () {
          cubit.getDriverTripsHistory();
        },) :
        state is GetDriverHistoryTripsSuccessState ?
        Padding(
          padding: const EdgeInsets.all(AppSizes.s15),
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.getDriverTripsHistory();
            },
            child: Column(
              children: [
                TotalEarningCard(totalEarning: cubit.getDriverTripsHistoryTotalPrice(),),
                const SizedBox(height: AppSizes.s10,),
                TotalRatingCard(totalRating: cubit.getDriverTripsHistoryTotalRating(),),
                const SizedBox(height: AppSizes.s10,),
                const Line(),
                const SizedBox(height: AppSizes.s10,),
                MyText(text: "Your Rates",style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                const SizedBox(height: AppSizes.s10,),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return RatingCard(tripData: cubit.driverHistoryTrips[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: AppSizes.s10,);
                    },
                    itemCount: cubit.driverHistoryTrips.length,
                  ),
                ),
              ],
            ),
          ),
        ) :
        const Center(child: CircularProgressIndicator());
      },
    );
  }
}
