import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Domain/Usecases/register_usecase.dart';
import 'package:twseela_driver/Presentation/Widgets/back_arrow.dart';
import 'package:twseela_driver/Presentation/Widgets/no_internet_box.dart';
import '../../../Domain/Usecases/update_driver_data_usecase.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/values_manager.dart';
import '../../Widgets/line.dart';
import '../../Widgets/my_elevation_button.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import '../../Widgets/profile_load.dart';
import 'Profile_Cubit/parfile_cubit.dart';
import 'Profile_Cubit/profile_stetes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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

          if(state is ProfileInitialState)
            {
              cubit.getUserData();
            }

          if(cubit.myData != null)
            {
              userNameController.text = cubit.myData!.name!;
              emailController.text = cubit.myData!.email!;
              phoneController.text = cubit.myData!.phone!;
              addressController.text = cubit.myData!.address!; 

              carNameController.text = cubit.myData!.vehicle!.name!; 
              carModelController.text = cubit.myData!.vehicle!.model!; 
              carNumberController.text = cubit.myData!.vehicle!.plateNumber!; 
              carColorController.text = cubit.myData!.vehicle!.color!;
            }


          return Scaffold(
            appBar: AppBar(
              leading: const BackArrow(),
              title: MyText(text: "Profile",style: Theme.of(context).appBarTheme.titleTextStyle!,
                size: AppSizes.s20,),
            ),
            body: (state is ProfileGetDataErrorState) ?
            NoInternetBox(message: state.failure.message!, fun: () {
              cubit.getUserData();
            },)
            : cubit.myData != null ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: RefreshIndicator(
                  onRefresh: () async {
                    cubit.getUserData();
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: AppSizes.s80,
                            ///child: Icon(Icons.person,size: AppSizes.s100,),
                            backgroundImage: cubit.userImage(),
                          ),
                          Positioned(
                            bottom: AppSizes.s8,
                            right: AppSizes.s4,
                            child: CircleAvatar(
                              backgroundColor: ColorManager.primary,
                              radius: AppSizes.s20,
                              child: IconButton(
                                onPressed: () {
                                  cubit.getUserImage();
                                },
                                icon: const Icon(Icons.camera_alt,color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.s20,),
                      const Line(),
                      const SizedBox(height: AppSizes.s20,),
                      MyText(text: "User Info",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
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
                      MyText(text: "Car Info",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
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

                      MyElevationButton(
                        fun: () {
                          UpdateUserDataUseCaseInput data = UpdateUserDataUseCaseInput(
                            name: userNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            vehicle: VehicleUseCaseInput(
                              name: carNameController.text,
                              model: carModelController.text,
                              plateNumber: carNumberController.text,
                              color: carColorController.text,
                              type: cubit.myData!.vehicle!.type!,
                            ),
                          );
                          cubit.imageFile != null ? cubit.updateUserImage(data: data,) : cubit.updateProfileInfo(data: data,);
                        },
                        textButton: "Update",
                      ),
                    ],
                  ),
                ),
              ),
            ) : const LoadData(),


          );
        },

    );
  }
}
