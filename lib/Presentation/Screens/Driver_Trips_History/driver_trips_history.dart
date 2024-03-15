import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/back_arrow.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';
import 'package:twseela_driver/Presentation/Widgets/no_internet_box.dart';
import 'package:twseela_driver/Presentation/Widgets/trip_card.dart';

import '../../Resources/color_manager.dart';
import '../../Widgets/my_elevation_button.dart';
import 'Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import 'Driver_History_Trips_Cubit/driver_history_trips_states.dart';

class DriverTripsHistoryScreen extends StatelessWidget {
  const DriverTripsHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHistoryTripsCubit, DriverHistoryTripsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = DriverHistoryTripsCubit.get(context);
        return Scaffold(
            appBar: AppBar(
                leading: const BackArrow(),
                title: MyText(
                  text: "Trips History",
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
                actions: [
                  DropdownButton(
                    value: cubit.selectedFilter,
                    onChanged: (value) {
                      cubit.changeSelectedFilter(value!);
                    },
                    items: cubit.filters.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: MyText(text: e, size: AppSizes.s15,style: Theme.of(context).textTheme.headlineMedium!,),
                      );
                    }).toList(),
                      dropdownColor: ColorManager.primary,
                  ),
                ],
            ),
            body: (state is GetDriverHistoryTripsErrorState) ?
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            MyText(
                              text: cubit.defaultFilter![index],
                              size: AppSizes.s15,
                              style: Theme.of(context).textTheme.displayLarge!,
                            ),
                            const SizedBox(
                              height: AppSizes.s5,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int indx) {
                                  return TripHistoryCard(tripData: cubit
                                      .defaultFilterMap[cubit.defaultFilter![index]]![indx]);
                                },
                                itemCount: cubit
                                    .defaultFilterMap[
                                cubit.defaultFilter![index]]!
                                    .length),
                            const SizedBox(
                              height: AppSizes.s5,
                            )
                          ]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemCount: cubit
                            .defaultFilterMap
                            .keys
                            .toList()
                            .length,
                      ),
                    ),
                  ) :
                  const Center(child: CircularProgressIndicator()));
      },
    );
  }
}