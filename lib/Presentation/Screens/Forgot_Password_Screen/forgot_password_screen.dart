import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Resources/values_manager.dart';
import '../../Widgets/my_elevation_button.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import 'Forgot_Password_Cubit/forgot_password_cubit.dart';
import 'Forgot_Password_Cubit/forgot_password_states.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => ForgotPasswordCubit(),
      child: BlocBuilder<ForgotPasswordCubit,ForgotPasswordStates>(
        builder: (context,state) {
          return Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(text: "Reset Password",size: AppSizes.s40,
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                      const SizedBox(height: AppSizes.s40,),
                      MyTextFormField(controller: emailController, validator: (email) {
                        if(email.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      labelText: "Email Address",
                        prefixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: AppSizes.s20,),
                      MyElevationButton(fun: () {
                        if(formKey.currentState!.validate()) {
                          ForgotPasswordCubit.get(context).forgotPassword(email: emailController.text);
                        }
                      }, textButton: "Reset Password")
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}