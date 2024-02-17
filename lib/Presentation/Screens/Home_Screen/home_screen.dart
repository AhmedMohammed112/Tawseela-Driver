import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:twseela_driver/App/Theme_Cubit/theme_cubit.dart';
import 'package:twseela_driver/Presentation/Resources/color_manager.dart';
import 'package:twseela_driver/Presentation/Screens/Drawer_Screen/drawer_screen.dart';
import 'package:twseela_driver/Presentation/Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_cubit.dart';
import 'package:twseela_driver/Presentation/Screens/Home_Screen/bottom_nav_bar_screens/map_screen/Map_Cubit/home_states.dart';
import 'package:twseela_driver/Presentation/Widgets/my_text.dart';
import '../../Resources/values_manager.dart';
import 'Bottom_Nav_Bar_Cubit/bottom_nav_bar_cubit.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => BottomNavBarCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context,  state) {  },
        builder: (BuildContext context,  state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            drawer: const NavDrawer(),
              appBar: AppBar(
                            elevation: 0,
                            leading: Builder(
                              builder: (BuildContext context) {
                                return IconButton(
                                  icon: const Icon(Icons.menu),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                );
                              },
                            ),
                            title: MyText(
                              text: cubit.titles[cubit.selectedIndex],
                              size: AppSizes.s25,
                            ),
                            actions: [
                              IconButton(
                                icon: Icon(
                                  ThemeCubit.get(context).isDark
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                ),
                                onPressed: () {
                                  ThemeCubit.get(context).changeMode();
                                },
                              ),
                            ],
                          ),
              bottomNavigationBar: CurvedNavigationBar(
                index: 0,
                height: 60.0,
                items: <Widget>[
                  Icon(Icons.location_on, size: 30,color: Theme.of(context).primaryColor),
                  Icon(Icons.history, size: 30,color: Theme.of(context).primaryColor),
                  Icon(Icons.star_rate, size: 30,color: Theme.of(context).primaryColor),
                  Icon(Icons.person, size: 30,color: Theme.of(context).primaryColor),
                ],
                color: Theme.of(context).primaryColorDark,
                buttonBackgroundColor: Theme.of(context).primaryColorDark,
                backgroundColor: Colors.white.withOpacity(0.1),
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 600),
                onTap: (index) {
                  cubit.onItemTapped(index);
                },
                letIndexChange: (index) => true,
              ),
              body: cubit.screens[cubit.selectedIndex],
            );
        },
      ),
    );
  }
}
