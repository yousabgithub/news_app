import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation layer/constants/constants.dart';

import '../presentation layer/screens/splash_screen.dart';
import '../presentation layer/widgets/theme.dart';

import 'Business Logic layer/bloc_observer.dart';
import 'Business Logic layer/cubits/news_cubit.dart';
import 'Business Logic layer/cubits/setting_cubit.dart';
import 'Business Logic layer/states/news_states.dart';
import 'Business Logic layer/states/setting_states.dart';
import 'Data Layer/web_services.dart';
import 'app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var pref = await SharedPreferences.getInstance();

  country = pref.getString('country') ?? 'eg';

  Bloc.observer = MyBlocObserver();
  DioHelper.initDio();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingCubit()..getThemePref(),
        ),
        BlocProvider(
          create: (context) => NewsCubit()
            ..getCountryFromPref()
            ..fetchGeneralNews()
            ..fetchBusinessNews()
            ..fetchScienceNews()
            ..fetchSportsNews()
            ..fetchHealthNews(),
        )
      ],
      child: BlocConsumer<SettingCubit, SettingStates>(
        listener: (context, state) {},
        builder: (context, state) => ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => BlocConsumer<NewsCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                locale: currentLocale,
                supportedLocales: const [
                  Locale("ar"),
                  Locale("en", "US"),
                  Locale("de"),
                  Locale("fr"),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var local in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == local.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
                themeMode: SettingCubit.getObject(context).theme,
                theme: Themes.light,
                darkTheme: Themes.dark,
              );
            },
          ),
        ),
      ),
    );
  }
}
