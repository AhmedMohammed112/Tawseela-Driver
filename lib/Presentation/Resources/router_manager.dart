import 'package:flutter/material.dart';
import 'package:twseela_driver/Presentation/Resources/page_slide_transition.dart';
import 'package:twseela_driver/Presentation/Screens/Settings/settings.dart';


import '../../App/di.dart';
import '../Screens/Driver_Trips_History/driver_trips_history.dart';
import '../Screens/Forgot_Password_Screen/forgot_password_screen.dart';
import '../Screens/Home_Screen/home_screen.dart';
import '../Screens/Landing_Screen/landing_page.dart';
import '../Screens/Login_Screen/login_screen.dart';
import '../Screens/Profile_Screen/profile_screen.dart';
import '../Screens/Register_Screen/register_screen.dart';
import '../Screens/Splash_Screen/splash_screen.dart';

class AppRoutes
{
    static const String splashScreen = '/';
    static const String landingPage = '/landingPage';
    static const String loginScreen = '/login';
    static const String registerScreen = '/register'; 
    static const String forgotPasswordScreen = '/forgotPassword';
    static const String homeScreen = '/home'; 
    static const String searchScreen = '/searchScreen';
    static const String profileScreen = '/profileScreen';
    static const String myTripsScreen = '/myTripsScreen';
    static const String settingsScreen = '/settingsScreen';
}

class RouterManager
{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch (settings.name)
    {
      case AppRoutes.splashScreen:
        init();
        return PageSlideTransition(page: const SplashScreen());
      case AppRoutes.landingPage:
        return PageSlideTransition(page: const LandingPage());
        case AppRoutes.homeScreen:
          initGetUserInfo();
          initUpdateUserInfo();
          initGetFormattedAddress();
          initGetDirectionDetailsInfo();
          initGetUserInfo();
          initGetDriverTripsHistory();
          initCancelTrip();
          initUpdateDriverTripsCount();
          initUpdateDriverStatus();
          initSaveDriverEarnings();
          initUpdateTripStatus();
          initSaveDeviceToken();
          initUpdateDriverLocation();
          initGetUserData();
          initGetRideRequestData();
          initGetDriverStatus();
          initGetRideRequestReference();
          initGetRequestDriverId();
          initLogout();
        return PageSlideTransition(page: const HomeScreen());
      case AppRoutes.profileScreen:
        initGetUserInfo();
        return PageSlideTransition(page: const ProfileScreen());
      case AppRoutes.myTripsScreen:
        initGetDriverTripsHistory();
        return PageSlideTransition(page: const DriverTripsHistoryScreen());
      case AppRoutes.loginScreen:
        initLogin();
        initGetUserInfo();
        return PageSlideTransition(page: LoginScreen());
        case AppRoutes.registerScreen:
          initRegister();
        return PageSlideTransition(page: RegisterScreen());
        case AppRoutes.forgotPasswordScreen:
          initForgetPassword(); 
        return PageSlideTransition(page: const ForgotPasswordScreen());
      case AppRoutes.settingsScreen:
        return PageSlideTransition(page: const SettingsScreen());
      default: // Error
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}