import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Domain/Usecases/forgot_password_usecase.dart';

import '../../../../App/di.dart';
import 'forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  final ForgotPasswordUsecase _forgotPasswordUsecase = sl<ForgotPasswordUsecase>();


  void forgotPassword({required String email}) async {
    emit(ForgotPasswordLoadingState());
    final result = await _forgotPasswordUsecase.execute(email);
    result.fold((failure) {
      emit(ForgotPasswordErrorState(failure.message!));
    }, (success) {
      emit(ForgotPasswordSuccessState());
    });
  }
}