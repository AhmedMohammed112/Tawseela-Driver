import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Screens/Register_Screen/Register_Cubit/register_states.dart';

import '../../../../App/di.dart';
import '../../../../Domain/Models/user_model.dart';
import '../../../../Domain/Usecases/register_usecase.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final RegisterUsecase _registerUsecase = sl<RegisterUsecase>();


  List<String> carTypes = [
    'Car',
    'Motor Cycle',
  ];
  String? selectedType;

  void selectVehicleType(String? value) {
    selectedType = value;
    emit(RegisterSelectVehicleTypeState());
  }





  bool isVisible = false;
  void changeVisibility() {
    isVisible = !isVisible;
    emit(RegisterChangeVisibilityState());
  }




  void userRegister({
    required UserDataUseCaseInput registerUseCaseInput,
  }) async {
    emit(RegisterLoadingState());
    (await _registerUsecase.execute(registerUseCaseInput,)).fold((l) {
      print(l.message);
      emit(RegisterErrorState(l.message.toString()));
    }, (r) {
      emit(RegisterSuccessState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  bool passwordValidator(String value) {
    RegExp regExp = RegExp(r'^(?=.*?[a-z])(?=.*?\d).{8,}$');
    if (regExp.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }
}