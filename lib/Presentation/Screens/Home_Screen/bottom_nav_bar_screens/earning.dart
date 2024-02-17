import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';
import 'package:twseela_driver/Presentation/Widgets/rate_bar.dart';

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
        return state is GetDriverHistoryTripsSuccessState
            ? Padding(
                padding: const EdgeInsets.all(AppSizes.s15),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          children: [
                            MyText(
                              text:
                                  "Total Earning: ${cubit.getDriverTripsHistoryTotalPrice()} \$", size: AppSizes.s25,
                              style: Theme.of(context).textTheme.displayLarge!,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s10,),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text:
                                  "Total Rating: ${cubit.getDriverTripsHistoryTotalRating()} ",
                              style: Theme.of(context).textTheme.displayLarge!,
                            ),
                            const SizedBox(height: AppSizes.s10,),
                            const Icon(Icons.star,color: Colors.amber,size: AppSizes.s40,)
                          ],
                        ),
                      ),
                    ),
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
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text:
                                        "Trip date: ${cubit.driverHistoryTrips[index].date}", style:
                                    Theme.of(context).textTheme.labelMedium!
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                          text:
                                          "Rate: ${cubit.driverHistoryTrips[index].rating}", style:
                                      Theme.of(context).textTheme.labelMedium!
                                      ),
                                      const SizedBox(width: AppSizes.s10,),
                                      RateBar(rate: cubit.driverHistoryTrips[index].rating!.toInt()),
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
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
