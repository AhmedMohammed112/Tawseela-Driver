import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../App/di.dart';
import '../../../../Domain/Usecases/login_usecase.dart';
import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final LoginUsecase _loginUsecase = sl<LoginUsecase>();

  void userLogin({
        required String email,
        required String password,

  }) async {
    (await _loginUsecase.execute(LoginUseCaseInput(
      email: email,
      password: password,
    ))).fold((l) {
      print(l.message.toString());
      emit(LoginErrorState(l.message.toString()));
    }, (r)  {
      emit(LoginSuccessState());
    });


  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  bool isRememberMe = false;
  void rememberMe(bool value) {
    isRememberMe = value;
    emit(LoginRememberMeState());
  }

}