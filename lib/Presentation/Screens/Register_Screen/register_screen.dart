import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Usecases/register_usecase.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/router_manager.dart';
import '../../Resources/values_manager.dart';
import '../../Widgets/authentication_error_box.dart';
import '../../Widgets/my_elevation_button.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import 'Register_Cubit/register_cubit.dart';
import 'Register_Cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final carNameController = TextEditingController();
  final carModelController = TextEditingController();
  final carColorController = TextEditingController();
  final carNumberController = TextEditingController();
  final personalDataFormKey = GlobalKey<FormState>();
  final carDataFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: PageView(
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.goToNextPage(index);
              },
              children: [
                buildPersonalDataPage(context),
                buildCarDataPage(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPersonalDataPage(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, AppRoutes.homeScreen);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Form(
          key: personalDataFormKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "Register", size: AppSizes.s40, style: Theme.of(context).textTheme.displayLarge!),
                    const SizedBox(height: AppSizes.s10),
                    MyText(text: "Create an account to continue", size: AppSizes.s20, style: Theme.of(context).textTheme.headlineMedium!),
                    const SizedBox(height: AppSizes.s40),
                    if (state is RegisterErrorState)
                      AuthenticationErrorBox(message: state.error),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value.isEmpty) return "User Name Required";
                        return null;
                      },
                      labelText: "User Name",
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) return "Email Required";
                        else if(!cubit.emailValidator(value)) return "Invalid Email";
                        return null;
                      },
                      labelText: "Email Address",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value.isEmpty) return "Phone Required";
                        else if(!cubit.emailValidator(value)) return "Invalid Phone";
                        return null;
                      },
                      labelText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value.isEmpty) return "Address Required";
                        return null;
                      },
                      labelText: "Address",
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password Required";
                        } else if (cubit.passwordValidator(value) == false) {
                          return 'password must be at least 8 characters';
                        }
                        return null;
                      },
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      secureText: RegisterCubit.get(context).isPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        icon: Icon(RegisterCubit.get(context).suffix),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password Confirmation Required";
                        } else if (confirmPasswordController.text != passwordController.text) {
                          return 'password does not match';
                        }
                        return null;
                      },
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock),
                      secureText: RegisterCubit.get(context).isPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        icon: Icon(
                          RegisterCubit.get(context).suffix,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.s40),
                    MyElevationButton(
                      fun: () {
                        if (personalDataFormKey.currentState!.validate()) {
                          cubit.next();
                        }
                      },
                      textButton: "Next",
                      size: AppSizes.s20,
                      shadowColor: ColorManager.primary,
                      elevation: 30,
                      widthButton: double.infinity,
                    ),
                    const SizedBox(height: AppSizes.s20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCarDataPage(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, AppRoutes.homeScreen);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Form(
          key: carDataFormKey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.back();
                      },
                      icon: const Icon(Icons.arrow_back, size: AppSizes.s30),
                    ),
                    const SizedBox(height: AppSizes.s50),
                    MyText(text: "Vehicle Data", size: AppSizes.s30, style: Theme.of(context).textTheme.displayLarge!),
                    const SizedBox(height: AppSizes.s20),
                    DropdownButtonFormField(
                      value: cubit.selectedType,
                      onChanged: (value) {
                        cubit.selectVehicleType(value);
                      },
                      validator: (value) {
                        if (value == null) return "Car Type Required";
                        return null;
                      },
                      items: cubit.carTypes.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: MyText(text: e, size: AppSizes.s20, style: Theme.of(context).textTheme.headlineMedium!),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: "Car Type",
                        prefixIcon: Icon(Icons.car_rental),
                      ),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    MyTextFormField(
                      controller: carNameController,
                      validator: (value) {
                        if (value.isEmpty) return "Car Name Required";
                        return null;
                      },
                      labelText: "Car Name",
                      prefixIcon: const Icon(Icons.car_rental),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: carModelController,
                      validator: (value) {
                        if (value.isEmpty) return "Car Model Required";
                        return null;
                      },
                      labelText: "Car Model",
                      prefixIcon: const Icon(Icons.car_rental),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: carNumberController,
                      validator: (value) {
                        if (value.isEmpty) return "Car Plate Number Required";
                        return null;
                      },
                      labelText: "Car Plate Number",
                      prefixIcon: const Icon(Icons.car_rental),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyTextFormField(
                      controller: carColorController,
                      validator: (value) {
                        if (value.isEmpty) return "Car Color Required";
                        return null;
                      },
                      labelText: "Car Color",
                      prefixIcon: const Icon(Icons.car_rental),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    MyElevationButton(
                      fun: () {
                        if (carDataFormKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            registerUseCaseInput: UserDataUseCaseInput(
                              name: userNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              password: passwordController.text,
                              review: [],
                              vehicle: VehicleUseCaseInput(
                                name: carNameController.text,
                                model: carModelController.text,
                                plateNumber: carNumberController.text,
                                color: carColorController.text,
                                type: cubit.selectedType!,
                              ),
                            ),
                          );
                        }
                      },
                      textButton: "Register",
                      size: AppSizes.s20,
                      shadowColor: ColorManager.primary,
                      elevation: 30,
                      widthButton: double.infinity,
                    ),
                    const SizedBox(height: AppSizes.s40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(text: "Already have an account?", size: AppSizes.s15, style: Theme.of(context).textTheme.labelMedium!),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.loginScreen);
                          },
                          child: MyText(text: "Login", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
