import 'package:flutter/material.dart';
import 'package:twseela_driver/Presentation/Resources/style_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.primary,
    //main color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.green,

    //card view theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSizes.s4,
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      elevation: AppSizes.s4,
      centerTitle: true,
      shadowColor: ColorManager.primary,
      titleTextStyle: boldText(
        fontSize: AppSizes.s20,
        color: ColorManager.darkPrimary,

      ),
    ),



    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s20),
        ),
      ),
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.primary,
    ),

    //Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.darkPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
        ),
        elevation: AppSizes.s4,
        shadowColor: ColorManager.white,
        textStyle: semiBoldText(
          fontSize: FontSizes.s17,
          color: ColorManager.white,
        ),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s20),
          topRight: Radius.circular(AppSizes.s20),
        ),
      ),
    ),



    dividerTheme: const DividerThemeData(
      color: ColorManager.black,
    ),




    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s12),
      ),
      tileColor: ColorManager.white,
      iconColor: ColorManager.darkPrimary,
      textColor: ColorManager.primary,
      selectedColor: ColorManager.primary,
      selectedTileColor: ColorManager.lightPrimary,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
      ),
    ),

    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(ColorManager.primary),
        checkColor: MaterialStateProperty.all<Color>(ColorManager.white),
        side: const BorderSide(color: ColorManager.black,width: AppSizes.s2,)
    ),



    iconTheme: IconThemeData(
      color: ColorManager.darkPrimary,
    ),



    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all<Color>(ColorManager.darkPrimary),
        )
    ),



    //Text theme
    textTheme: TextTheme(
        displayLarge: semiBoldText(
          fontSize: FontSizes.s16,
          color: ColorManager.darkPrimary,
        ),
        headlineMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.darkPrimary,
        ),
        labelMedium: mediumText(
          fontSize: FontSizes.s14,
          color: ColorManager.darkPrimary,
        ),
        labelLarge: regularText(
          color: ColorManager.lightPrimary,
        ),
        bodyLarge: regularText(
          color: ColorManager.darkGrey,
        ),
        labelSmall:
        boldText(color: ColorManager.darkPrimary, fontSize: AppSizes.s12)),

    //Input theme Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      iconColor: ColorManager.darkPrimary,
      prefixIconColor: ColorManager.darkPrimary,
      suffixIconColor: ColorManager.darkPrimary,

      // make the input color black
      suffixStyle: regularText(
        color: ColorManager.black,
        fontSize: FontSizes.s16,
      ),

      //Label Text Style
      labelStyle: regularText(
        color: ColorManager.black,
        fontSize: FontSizes.s16,
      ),

      //Hint Text Style
      hintStyle: mediumText(
        color: ColorManager.grey,
        fontSize: FontSizes.s14,
      ),

      //Error Text Style
      errorStyle: regularText(
        color: ColorManager.red,
        fontSize: FontSizes.s12,
      ),

      //Border Style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: BorderSide(
          color: ColorManager.darkPrimary,
          width: AppSizes.s2,
        ),
      ),

      //Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: const BorderSide(
          color: ColorManager.darkGrey,
          width: AppSizes.s2,
        ),
      ),

      //Error Border Style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: const BorderSide(
          color: ColorManager.red,
          width: AppSizes.s2,
        ),
      ),

      //Focused Error Border Style
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
          borderSide: BorderSide(
            color: ColorManager.darkPrimary,
            width: AppSizes.s2,
          ),
          gapPadding: AppSizes.s8
      ),
    ),
  );
}


ThemeData getDarkThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    //main color
    primaryColor: Colors.grey.shade900,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.green,

    //card view theme
    cardTheme: const CardTheme(
      color: ColorManager.grey,
      shadowColor: ColorManager.grey,
      elevation: AppSizes.s4,
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.lightGrey,
      elevation: AppSizes.s4,
      centerTitle: true,
      shadowColor: ColorManager.primary,
      titleTextStyle: regularText(
        fontSize: AppSizes.s16,
        color: ColorManager.white,
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: ColorManager.darkGrey,
      titleTextStyle: semiBoldText(
        fontSize: FontSizes.s16,
        color: ColorManager.darkGrey,
      ),
      contentTextStyle: regularText(
        fontSize: FontSizes.s14,
        color: ColorManager.white,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s20),
        ),
      ),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorManager.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s20),
          topRight: Radius.circular(AppSizes.s20),
        ),
      ),
    ),

    drawerTheme: DrawerThemeData(
      elevation: AppSizes.s4,
      shadowColor: ColorManager.white,
      backgroundColor: Colors.grey.shade900,
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.primary,
    ),


    //Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
        ),
        elevation: AppSizes.s4,
        shadowColor: ColorManager.lightPrimary,
        textStyle: semiBoldText(
          fontSize: FontSizes.s17,
          color: ColorManager.white,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: ColorManager.white,
    ),


    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s12),
      ),
      iconColor: ColorManager.white,
      textColor: ColorManager.white,
      selectedColor: ColorManager.white,
      selectedTileColor: ColorManager.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
      ),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorManager.darkGrey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
          borderSide: BorderSide(
            color: ColorManager.white,
            width: AppSizes.s2,
          ),
        ),
      ),
      textStyle: regularText(
        color: ColorManager.black,
        fontSize: FontSizes.s16,
      ),
    ),


    iconTheme: const IconThemeData(
      color: ColorManager.white,
    ),

    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all<Color>(ColorManager.white),
        )
    ),

    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(ColorManager.white),
        checkColor: MaterialStateProperty.all<Color>(ColorManager.black),
        side: const BorderSide(color: ColorManager.white,width: AppSizes.s2,)
    ),


    //Text theme
    textTheme: TextTheme(
        displayLarge: semiBoldText(
          fontSize: FontSizes.s16,
          color: ColorManager.white,
        ),
        headlineMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.white,
        ),
        labelMedium: mediumText(
          fontSize: FontSizes.s14,
          color: ColorManager.white,
        ),
        labelLarge: regularText(
          color: ColorManager.white,
        ),
        bodyLarge: regularText(
          color: ColorManager.white,
        ),
        labelSmall:
        boldText(color: ColorManager.white, fontSize: AppSizes.s12)),

    //Input theme Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      iconColor: ColorManager.white,
      prefixIconColor: ColorManager.white,
      suffixIconColor: ColorManager.white,

      //Label Text Style
      labelStyle: regularText(
        color: ColorManager.white,
        fontSize: FontSizes.s18,
      ),

      //Hint Text Style
      hintStyle: mediumText(
        color: ColorManager.white,
        fontSize: FontSizes.s14,
      ),

      //Error Text Style
      errorStyle: regularText(
        color: ColorManager.red,
        fontSize: FontSizes.s12,
      ),

      //Border Style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSizes.s2,
        ),
      ),

      //Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: const BorderSide(
          color: ColorManager.grey,
          width: AppSizes.s2,
        ),
      ),

      //Error Border Style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s20),
        borderSide: const BorderSide(
          color: ColorManager.red,
          width: AppSizes.s2,
        ),
      ),

      //Focused Error Border Style
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSizes.s2,
          ),
          gapPadding: AppSizes.s8
      ),
    ),
  );
} //end of dark theme