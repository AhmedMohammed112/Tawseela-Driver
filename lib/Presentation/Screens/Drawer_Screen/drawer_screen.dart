import 'package:flutter/material.dart';
import 'package:twseela_driver/Presentation/Widgets/drawer_header.dart';
import 'package:twseela_driver/Presentation/Widgets/drawer_list_tiles.dart';
import '../../Resources/values_manager.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      shape: const RoundedRectangleBorder( 
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSizes.s60),
          topRight: Radius.circular(AppSizes.s60),
        ) 
      ),
        elevation: AppSizes.s0,
        surfaceTintColor: Colors.red,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ListView(
          children:  const [
            CustomDrawerHeader(),
            DrawerListTiles(),
          ],
        ),
    );
  }
}
