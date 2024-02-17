import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:twseela_driver/Domain/Usecases/get_driver_id_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/get_driver_trips_history_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/save_device-token_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/save_driver_earnings_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_status_usecase.dart';


import '../Data/App_Service_Client/app_api.dart';
import '../Data/Network/connection_checker.dart';
import '../Data/Remote_Data_Source/remote_data_source.dart';
import '../Data/Repository_Implementer/repository_implementer.dart';
import '../Domain/Repository/repository.dart';
import '../Domain/Usecases/cancel_trip_usecase.dart';
import '../Domain/Usecases/forgot_password_usecase.dart';
import '../Domain/Usecases/get_direction_info_usecase.dart';
import '../Domain/Usecases/get_driver_status_usecase.dart';
import '../Domain/Usecases/get_formatted-address_usecase.dart';
import '../Domain/Usecases/get_driver_data_usecase.dart';
import '../Domain/Usecases/get_ride-request_data.dart';
import '../Domain/Usecases/get_ride_request_reference_usecase.dart';
import '../Domain/Usecases/get_user_data_usecase.dart';
import '../Domain/Usecases/log_out_usecase.dart';
import '../Domain/Usecases/login_usecase.dart';
import '../Domain/Usecases/register_usecase.dart';
import '../Domain/Usecases/update_driver_location_usecase.dart';
import '../Domain/Usecases/update_driver_trips_count_usecase.dart';
import '../Domain/Usecases/update_trip_history.dart';
import '../Domain/Usecases/update_driver_data_usecase.dart';
import '../Presentation/Screens/Forgot_Password_Screen/Forgot_Password_Cubit/forgot_password_cubit.dart';
import '../Presentation/Screens/Login_Screen/Login_Cubit/login_cubit.dart';
import '../Presentation/Screens/Register_Screen/Register_Cubit/register_cubit.dart';

var sl = GetIt.instance;

void init() async {
  sl.registerLazySingleton(() => AppServiceClientFirebaseApi());

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl<AppServiceClientFirebaseApi>()));

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(InternetConnectionChecker()));

  sl.registerLazySingleton<Repository>(() => RepositoryImplementer(sl<RemoteDataSource>(), ConnectionCheckerImpl(InternetConnectionChecker())));

}

void initRegister() {
  if (!sl.isRegistered<RegisterUsecase>()) {
    sl.registerFactory<RegisterUsecase>(() => RegisterUsecase(repository: sl<Repository>()));
    sl.registerFactory<RegisterCubit>(() => RegisterCubit());
  }
}


void initLogin() {
  if (!sl.isRegistered<LoginUsecase>()) {
    sl.registerFactory<LoginUsecase>(() => LoginUsecase(repository: sl<Repository>()));
    sl.registerFactory<LoginCubit>(() => LoginCubit());
  }
}

void initForgetPassword() {
  if (!sl.isRegistered<ForgotPasswordUsecase>()) {
    sl.registerFactory<ForgotPasswordUsecase>(() => ForgotPasswordUsecase(repository: sl<Repository>()));
    sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
  }
}

void initGetUserInfo() {
  if (!sl.isRegistered<GetCurrentDriverInfoUsecase>()) {
    sl.registerFactory<GetCurrentDriverInfoUsecase>(() => GetCurrentDriverInfoUsecase(repository: sl<Repository>()));
  }
}

void initUpdateUserInfo() {
  if (!sl.isRegistered<UpdateUserDataUsecase>()) {
    sl.registerFactory<UpdateUserDataUsecase>(() => UpdateUserDataUsecase(repository: sl<Repository>()));
  }
}

void initLogout() {
  if (!sl.isRegistered<LogoutUsecase>()) {
    sl.registerFactory<LogoutUsecase>(() => LogoutUsecase(repository: sl<Repository>()));
  }
}

void initGetFormattedAddress() {
  if(!sl.isRegistered<GetFormattedAddressUsecase>()) {
    sl.registerFactory<GetFormattedAddressUsecase>(() => GetFormattedAddressUsecase(repository: sl<Repository>()));
  }
}

void initGetDirectionDetailsInfo() {
  if(!sl.isRegistered<GetDirectionDetailsInfoUsecase>()) {
    sl.registerFactory<GetDirectionDetailsInfoUsecase>(() => GetDirectionDetailsInfoUsecase(repository: sl<Repository>()));
  }
}

void initGetDriverTripsHistory() {
  if(!sl.isRegistered<GetDriverTripsHistoryUsecase>()) {
    sl.registerFactory<GetDriverTripsHistoryUsecase>(() => GetDriverTripsHistoryUsecase(repository: sl<Repository>()));
  }
}

void initCancelTrip() {
  if(!sl.isRegistered<CancelTripUsecase>()) {
    sl.registerFactory<CancelTripUsecase>(() => CancelTripUsecase(repository: sl<Repository>()));
  }
}

void initUpdateTripStatus() {
  if(!sl.isRegistered<UpdateTripStatusUsecase>()) {
    sl.registerFactory<UpdateTripStatusUsecase>(() => UpdateTripStatusUsecase(repository: sl<Repository>()));
  }
}

void initSaveDriverEarnings() {
  if(!sl.isRegistered<SaveDriverEarningsUsecase>()) {
    sl.registerFactory<SaveDriverEarningsUsecase>(() => SaveDriverEarningsUsecase(repository: sl<Repository>()));
  }
}

void initUpdateDriverTripsCount() {
  if(!sl.isRegistered<UpdateDriverTripsCountUsecase>()) {
    sl.registerFactory<UpdateDriverTripsCountUsecase>(() => UpdateDriverTripsCountUsecase(repository: sl<Repository>()));
  }
}

void initUpdateDriverStatus() {
  if(!sl.isRegistered<UpdateDriverStatusUsecase>()) {
    sl.registerFactory<UpdateDriverStatusUsecase>(() => UpdateDriverStatusUsecase(repository: sl<Repository>()));
  }
}

void initSaveDeviceToken() {
  if(!sl.isRegistered<SaveDeviceTokenUsecase>()) {
    sl.registerFactory<SaveDeviceTokenUsecase>(() => SaveDeviceTokenUsecase(repository: sl<Repository>()));
  }
}

void initUpdateDriverLocation() {
  if(!sl.isRegistered<UpdateDriverLocationUsecase>()) {
    sl.registerFactory<UpdateDriverLocationUsecase>(() => UpdateDriverLocationUsecase(repository: sl<Repository>()));
  }
}

void initGetUserData() {
  if(!sl.isRegistered<GetUserDataUsecase>()) {
    sl.registerFactory<GetUserDataUsecase>(() => GetUserDataUsecase(repository: sl<Repository>()));
  }
}

void initGetRideRequestData() {
  if(!sl.isRegistered<GetRideRequestDataUsecase>()) {
    sl.registerFactory<GetRideRequestDataUsecase>(() => GetRideRequestDataUsecase(repository: sl<Repository>()));
  }
}

void initGetDriverStatus() {
  if(!sl.isRegistered<GetDriverStatusUsecase>()) {
    sl.registerFactory<GetDriverStatusUsecase>(() => GetDriverStatusUsecase(repository: sl<Repository>()));
  }
}

void initGetRideRequestReference() {
  if(!sl.isRegistered<GetRideRequestReferenceUsecase>()) {
    sl.registerFactory<GetRideRequestReferenceUsecase>(() => GetRideRequestReferenceUsecase(repository: sl<Repository>()));
  }
}

void initGetRequestDriverId() {
  if(!sl.isRegistered<GetRequestDriverIdUsecase>()) {
    sl.registerFactory<GetRequestDriverIdUsecase>(() => GetRequestDriverIdUsecase(repository: sl<Repository>()));
  }
}

// void initGetPredictions() {
//   if(!sl.isRegistered<GetPredictionsUsecase>()) {
//     sl.registerFactory<GetPredictionsUsecase>(() => GetPredictionsUsecase(repository: sl<Repository>()));
//   }
// }
//
// void initGetPlaceDetails() {
//   if(!sl.isRegistered<GetPlaceDetailsUsecase>()) {
//     sl.registerFactory<GetPlaceDetailsUsecase>(() => GetPlaceDetailsUsecase(repository: sl<Repository>()));
//   }
// }