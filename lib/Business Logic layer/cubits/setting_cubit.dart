import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states/setting_states.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(InitSettingStates());

  static SettingCubit getObject(context) => BlocProvider.of(context);

  /// Programming of the background color gradient of the top bar
  /// And Theme Mode

  ThemeMode theme = ThemeMode.light;
  String textTheme = 'light';
  List<Color> gradientDark = [
    const Color.fromARGB(255, 64, 64, 64),
    const Color.fromARGB(255, 38, 38, 38),
  ];
  List<Color> gradientLight = [
    const Color.fromARGB(255, 196, 8, 8),
    const Color.fromARGB(255, 49, 2, 2),
  ];
  late List<Color> gradientColorStart = gradientLight;

  onChangeTheme() async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
      textTheme = 'dark';

      gradientColorStart = gradientDark;
    } else {
      theme = ThemeMode.light;
      textTheme = 'light';

      gradientColorStart = gradientLight;
    }

    var pref = await SharedPreferences.getInstance();
    pref.setString('textTheme', textTheme);

    emit(SettingOnChangeTheme());
  }

  getThemePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'light';

    listView = pref.getBool('view') ?? false;
    if (textTheme == 'light') {
      theme = ThemeMode.light;
      gradientColorStart = gradientLight;
    } else {
      theme = ThemeMode.dark;
      gradientColorStart = gradientDark;
    }

    emit(SettingGetThemePref());
  }

  ///Programming for list or grid presentation
  /// **Note** the output was called in (getThemePref)
  bool listView = false;

  onChangeView(newView) async {
    listView = newView;
    emit(SettingOnChangeView());
    var pref = await SharedPreferences.getInstance();

    pref.setBool('view', listView);
  }
}
