import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Resources/color_manager.dart';
import '../../../Resources/values_manager.dart';
import '../../../Widgets/line.dart';
import '../../../Widgets/my_text.dart';
import '../../../Widgets/my_text_field.dart';
import '../../../Widgets/profile_load.dart';
import '../../Profile_Screen/Profile_Cubit/parfile_cubit.dart';
import '../../Profile_Screen/Profile_Cubit/profile_stetes.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController(); 


    TextEditingController carNameController = TextEditingController(); 
    TextEditingController carModelController = TextEditingController(); 
    TextEditingController carNumberController = TextEditingController(); 
    TextEditingController carColorController = TextEditingController(); 


    return BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = ProfileCubit.get(context);

          if (cubit.myData != null) {
            userNameController.text = cubit.myData!.name!;
            emailController.text = cubit.myData!.email!;
            phoneController.text = cubit.myData!.phone!;
            addressController.text = cubit.myData!.address!;

            carNameController.text = cubit.myData!.vehicle!.name!;
            carModelController.text = cubit.myData!.vehicle!.model!;
            carNumberController.text = cubit.myData!.vehicle!.plateNumber!;
            carColorController.text = cubit.myData!.vehicle!.color!;
          }



          return cubit.myData != null ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20, vertical: AppSizes.s30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.s80,
                        backgroundImage: cubit.userImage(),
                      ),
                      const Positioned(
                        bottom: AppSizes.s8,
                        right: AppSizes.s4,
                        child: CircleAvatar(
                          radius: AppSizes.s20,
                          child: Icon(Icons.camera_alt, color: ColorManager
                              .white, size: AppSizes.s20,),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s20,),
                  const Line(),
                  const SizedBox(height: AppSizes.s20,),
                  MyText(text: "User Info", size: AppSizes.s20, style: Theme
                      .of(context)
                      .textTheme
                      .displayLarge!,),
                  const SizedBox(height: AppSizes.s20,),
                  MyTextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value.isEmpty) return "User Name Required";
                        return null;
                      },
                      labelText: "User Name",
                      prefixIcon: const Icon(Icons.person)),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) return "Email Required";
                        return null;
                      },
                      labelText: "Email Address",
                      prefixIcon: const Icon(Icons.email)),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value.isEmpty) return "Phone Required";
                      return null;
                    },
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value.isEmpty) return "Address Required";
                      return null;
                    },
                    labelText: "Address",
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  const SizedBox(
                      height: AppSizes.s50
                  ),
                  const Line(),
                  // car info
                  const SizedBox(height: AppSizes.s20,),
                  MyText(text: "Car Info", size: AppSizes.s20, style: Theme
                      .of(context)
                      .textTheme
                      .displayLarge!,),
                  const SizedBox(height: AppSizes.s20,),
                  MyTextFormField(
                    controller: carNameController,
                    validator: (value) {
                      if (value.isEmpty) return "Car Name Required";
                      return null;
                    },
                    labelText: "Car Name",
                    prefixIcon: const Icon(Icons.car_rental),
                  ),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                    controller: carModelController,
                    validator: (value) {
                      if (value.isEmpty) return "Car Model Required";
                      return null;
                    },
                    labelText: "Car Model",
                    prefixIcon: const Icon(Icons.car_rental),
                  ),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                    controller: carNumberController,
                    validator: (value) {
                      if (value.isEmpty) return "Car Number Required";
                      return null;
                    },
                    labelText: "Car Number",
                    prefixIcon: const Icon(Icons.car_rental),
                  ),
                  const SizedBox(
                      height: AppSizes.s20
                  ),
                  MyTextFormField(
                    controller: carColorController,
                    validator: (value) {
                      if (value.isEmpty) return "Car Color Required";
                      return null;
                    },
                    labelText: "Car Color",
                    prefixIcon: const Icon(Icons.car_rental),
                  ),
                  const SizedBox(
                      height: AppSizes.s50
                  ),

                  // MyElevationButton(
                  //   fun: () {
                  //     cubit.updateProfileInfo(
                  //       name: userNameController.text,
                  //       email: emailController.text,
                  //       phone: phoneController.text,
                  //       address: addressController.text,
                  //     );
                  //   },
                  //   textButton: "Update",
                  // ),
                ],
              ),
            ),
          ) : const LoadData();
        }
        );

  }
}
