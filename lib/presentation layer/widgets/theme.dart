import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData light = ThemeData(
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 10.w,
      ),
      color: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xff9e2a2b),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 8,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        ///titleNews And Date
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w700,
        height: 1.1,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.blueGrey,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.blue,
        fontWeight: FontWeight.w900,
      ),
      bodySmall: TextStyle(
        ///tabBar title
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        ///tabBar title
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 51),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color(0xffcad2c5),
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 64, 64, 64),
      elevation: 20,
      margin: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color.fromARGB(255, 64, 64, 64),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 8,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color(0xffcad2c5),
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: 14.sp,
        color: const Color(0xffcad2c5),
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.blueGrey,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        ///titleNews And Date
        fontSize: 18.sp,
        color: Colors.white70,
        fontWeight: FontWeight.w700,
        height: 1.1,
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.blue,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}
