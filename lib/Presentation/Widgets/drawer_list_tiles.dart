import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Screens/Profile_Screen/Profile_Cubit/parfile_cubit.dart';
import 'package:twseela_driver/Presentation/Screens/Profile_Screen/Profile_Cubit/profile_stetes.dart';

import '../../App/di.dart';
import '../../App/Theme_Cubit/theme_cubit.dart';
import '../../Domain/Usecases/log_out_usecase.dart';
import '../Resources/router_manager.dart';
import '../Resources/values_manager.dart';
import 'line.dart';
import 'my_text.dart';

class DrawerListTiles extends StatelessWidget {
  const DrawerListTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileStates>(
      builder: (context,state) {
        var cubit = ProfileCubit.get(context);
        LogoutUsecase logoutUsecase = sl<LogoutUsecase>();

        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              horizontalTitleGap: AppSizes.s40,
              title: MyText(text: "Profile",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profileScreen);
              },
            ),
            ListTile(
                leading: const Icon(Icons.track_changes),
                horizontalTitleGap: AppSizes.s40,
                title: MyText(text: "My Trips",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.myTripsScreen);
                  },
            ),
            ListTile(
                leading: const Icon(Icons.payment),
                horizontalTitleGap: AppSizes.s40,
                title: MyText(text: "Payment",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,
                )
            ),
            ListTile(
                leading: const Icon(Icons.support_agent),
                horizontalTitleGap: AppSizes.s40,
                title: MyText(text: "Help",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,
                )
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              horizontalTitleGap: AppSizes.s40,
              title: MyText(text: "Settings",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
              // make List tile to be change the mode

              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settingsScreen);
              },
            ),
            const Line(),
            ListTile(
              leading: const Icon(Icons.logout),
              horizontalTitleGap: AppSizes.s40,
              title: MyText(text: "Logout",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
              // make List tile to be change the mode

              onTap: () async {
                await logoutUsecase.execute(null);
              },
            ),
          ],
        );
      },
    );
  }
}
