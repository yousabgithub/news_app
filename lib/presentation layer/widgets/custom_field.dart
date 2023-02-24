import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic layer/cubits/setting_cubit.dart';

class CustomField extends StatelessWidget {
  final void Function()? onPressedSuffixIcon;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController controller;

  const CustomField({
    Key? key,
    required this.onPressedSuffixIcon,
    required this.onFieldSubmitted,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = SettingCubit.getObject(context).theme == ThemeMode.dark;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 15.w,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          fillColor: isDark ? const Color(0xff457b9d) : Colors.amber,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.white, width: 0),
          ),
          enabled: true,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            child: Icon(
              Icons.search,
              size: 30.h,
              color: const Color.fromARGB(255, 38, 38, 115),
            ),
          ),
          suffixIcon: IconButton(
              onPressed: onPressedSuffixIcon,
              icon: Icon(
                Icons.cancel,
                color: isDark ? Colors.black : const Color(0xff457b9d),
                size: 22.h,
              )),
        ),
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
