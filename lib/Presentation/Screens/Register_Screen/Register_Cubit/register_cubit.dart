import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Resources/router_manager.dart';
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

  final PageController pageController = PageController();

  int currentPageIndex = 0;

  void next() {
    if (currentPageIndex != 2){
      currentPageIndex ++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(ChangePageState());
  }

  void back() {
    if (currentPageIndex != 0){
      currentPageIndex --;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(ChangePageState());
  }

  void goToNextPage(int index) {
    currentPageIndex = index;
    emit(ChangePageState());
  }




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

  bool emailValidator(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$');
    if (regExp.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool phoneValidator(String value) {
    // check if the phone number is 11 digits only and the first digit is 0 and the second digit is 1 and the remaining numbers do not matter
    RegExp regExp = RegExp(r'^01[0-9]{9}$');
    if (regExp.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }


}