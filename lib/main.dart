import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'App/Bloc_Observer.dart';
import 'App/Push_Notification/notifications.dart';
import 'App/Constants/constants.dart';
import 'App/di.dart';
import 'App/shared.dart';
import 'App/Theme_Cubit/theme_cubit.dart';
import 'App/Theme_Cubit/theme_states.dart';
import 'Presentation/Resources/router_manager.dart';
import 'Presentation/Resources/theme_manager.dart';
import 'Presentation/Screens/Driver_Trips_History/Driver_History_Trips_Cubit/driver_history_trips_cubit.dart';
import 'Presentation/Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_cubit.dart';
import 'Presentation/Screens/Profile_Screen/Profile_Cubit/parfile_cubit.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //print("backGround ${message.messageId}");
}

void main() async {
  initSaveDeviceToken();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await SharedPref.init();
  Bloc.observer = MyBlocObserver(); 
  init();
  PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
  pushNotificationSystem.generateToken();
  Location location = Location();
  await location.requestPermission();
  currentLocationData = await location.getLocation();
  bool? isDark = SharedPref.getData(key: 'IsDark');

  String? tripData = SharedPref.getTripData();
  currentTripData = tripData;
  print("CURRENT TRIP DATA IS: $tripData");
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => ThemeCubit()..changeMode(fromShared: isDark)),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => HomeCubit()..getCurrentUserData()..getMyCurrentLocation()..getToken()),
          BlocProvider(create: (context) => DriverHistoryTripsCubit()..getDriverTripsHistory()),
        ],

        child: BlocConsumer<ThemeCubit, ThemeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                title: 'Tawseela',
                debugShowCheckedModeBanner: false,
                theme: getLightThemeData(),
                darkTheme: getDarkThemeData(),
                themeMode: ThemeCubit
                    .get(context)
                    .isDark ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: RouterManager.generateRoute,
                initialRoute: AppRoutes.splashScreen,
              );
            }
            )
    );
  }
}

// aaaa@gmail.com
