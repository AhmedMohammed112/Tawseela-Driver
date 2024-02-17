import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Screens/Profile_Screen/Profile_Cubit/parfile_cubit.dart';
import 'package:twseela_driver/Presentation/Screens/Profile_Screen/Profile_Cubit/profile_stetes.dart';
import 'package:twseela_driver/Presentation/Widgets/profile_load.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileStates>(
      builder: (context,state) {
        var cubit = ProfileCubit.get(context);

        return
          cubit.myData != null ?
          SizedBox(
          height: AppSizes.s250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: AppSizes.s50,
                      backgroundImage: cubit.userImage(),
                    ),
                    const SizedBox(width: AppSizes.s16,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: cubit.myData!.name!,size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                          MyText(text: cubit.myData!.email!,style: Theme.of(context).textTheme.headlineMedium!,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.s10,
              ),

            ],
          ),
        ) : const DrawerLoading();
      },
    );
  }
}
