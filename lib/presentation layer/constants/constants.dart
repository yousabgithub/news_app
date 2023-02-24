import 'package:flutter/material.dart';

void navigatorTo(BuildContext context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

// this is default Current Locale in first  Start app
Locale currentLocale = const Locale("ar");

//  this is default Direction  in first  Start app
//  because the default Current Locale is ("ar")
TextDirection defaultDirection = TextDirection.rtl;

// default Country is egypt
String country = "eg";
