import 'package:bloc/bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Presentation/Screens/Home_Screen/bottom_nav_bar_screens/driver_trips_history_screen.dart';
import 'package:twseela_driver/Presentation/Screens/Home_Screen/bottom_nav_bar_screens/driver_profile_screen.dart';

import '../bottom_nav_bar_screens/map_screen/map_screen.dart';
import 'bottom_nav_bar_states.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit() : super(BottomNavBarInitialState());

  static BottomNavBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const MapScreen(),
    const DriverTripsHistory(),
    Container(),
    const UserProfileScreen(),
  ];

  List<String> titles = [
    "Home",
    "Likes",
    "Search",
    "Profile",
  ];

  int selectedIndex = 0;


  void onItemTapped(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavState());
  }
}