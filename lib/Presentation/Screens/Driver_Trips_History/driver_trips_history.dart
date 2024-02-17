import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/back_arrow.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';

import '../../Resources/color_manager.dart';
import '../../Widgets/my_elevation_button.dart';
import 'Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import 'Driver_History_Trips_Cubit/driver_history_trips_states.dart';

class DriverTripsHistoryScreen extends StatelessWidget {
  const DriverTripsHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHistoryTripsCubit, DriverHistoryTripsStates>(
      listener: (BuildContext context, state) {
            // if (state is GetDriverHistoryTripsErrorState) {
            //           showDialog(
            //             context: context,
            //             builder: (context) => AlertDialog(
            //               title: MyText(
            //                 text: state.failure.message!,
            //                 size: AppSizes.s20,
            //                 style: Theme.of(context).textTheme.labelSmall!,
            //               ),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () {
            //                     DriverHistoryTripsCubit.get(context).getDriverTripsHistory();
            //                     Navigator.pop(context);
            //                   },
            //                   child: MyText(
            //                     text: "Retry",
            //                     size: AppSizes.s20,
            //                     style: Theme.of(context).textTheme.labelMedium!,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }
      },
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
                  ) :
                  state is GetDriverHistoryTripsSuccessState ?
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.s15),
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
                                return Card(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(AppSizes.s20),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text:
                                          "From: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].originAddress}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "To: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].destinationAddress}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "Date: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].date.substring(0, 10)}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "Time: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].date.substring(11, 16)}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "Rating: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].tripStatus}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "Status: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].rating}",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                        const SizedBox(
                                          height: AppSizes.s5,
                                        ),
                                        MyText(
                                          text:
                                          "Fare: ${cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx].fareAmount} \$",
                                          size: AppSizes.s15,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
                  ) :
                  const Center(child: CircularProgressIndicator()));
      },
    );
  }
}