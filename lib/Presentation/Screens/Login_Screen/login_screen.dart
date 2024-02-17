import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/router_manager.dart';
import '../../Resources/values_manager.dart';
import '../../Widgets/authentication_error_box.dart';
import '../../Widgets/my_elevation_button.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import 'Login_Cubit/login_cubit.dart';
import 'Login_Cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {},
                builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "Login", size: AppSizes.s40, style: Theme.of(context).textTheme.displayLarge!,),
                        const SizedBox(
                          height: AppSizes.s40,
                        ),
                        if (state is LoginErrorState)
                          AuthenticationErrorBox(message: state.error,),
                          const SizedBox(
                            height: AppSizes.s20,
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
                          height: AppSizes.s20,
                        ),
                        MyTextFormField(
                          controller: passwordController,
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          validator: (value) {
                            if (value.isEmpty) return "Password Required";
                            return null;
                          },
                          suffixIcon: IconButton(
                              onPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                LoginCubit.get(context).suffix,
                              )),
                          secureText: LoginCubit.get(context).isPassword,
                          //type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: AppSizes.s20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                                value: LoginCubit.get(context).isRememberMe,
                                onChanged: (value) {
                                  LoginCubit.get(context)
                                      .rememberMe(value!);
                                },
                                // change color of checkbox border 
                                side: Theme.of(context).checkboxTheme.side
                            ),
                            MyText(
                              text: "Remember Me",
                              size: AppSizes.s15,
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
                                },
                                child: MyText(text: "Forget Password ?",size: AppSizes.s15, style: Theme.of(context).textTheme.labelMedium!,)),

                          ],
                        ),
                        const SizedBox(
                          height: AppSizes.s40,
                        ),
                        MyElevationButton(
                          fun: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          textButton: "Login",
                          shadowColor: ColorManager.black,
                          elevation: AppSizes.s30,
                          size: AppSizes.s20,
                        ),
                        const SizedBox(
                          height: AppSizes.s40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: "Don't have account?",
                              size: AppSizes.s15,
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                            const SizedBox(
                              width: AppSizes.s10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.registerScreen);
                                },
                                child: MyText(
                                    text: "Register", size: AppSizes.s20
                                    ,style: Theme.of(context).textTheme.displayLarge!,)),
                          ],
                        ),
                        const SizedBox(
                          height: AppSizes.s20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
