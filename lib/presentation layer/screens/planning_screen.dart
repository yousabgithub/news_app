import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_news/app_localizations.dart';

import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import 'business_screen.dart';
import 'health_screen.dart';
import 'science_screen.dart';
import 'search_screen.dart';
import 'sports_screen.dart';

import '../constants/constants.dart';
import 'general_screen.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> newsScreens = const [
    GeneralNewsScreen(),
    BusinessNewsScreen(),
    ScienceNewsScreen(),
    SportsNewsScreen(),
    HealthNewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> categoriesList = [
      'general'.translate(context),
      'business'.translate(context),
      'science'.translate(context),
      'sports'.translate(context),
      'health'.translate(context),
    ];

    SettingCubit settingCubit = SettingCubit.getObject(context);
    NewsCubit newsCubit = NewsCubit.getObject(context);
    bool isDark = settingCubit.theme == ThemeMode.dark;

    return Directionality(
      textDirection: defaultDirection,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          isDark,
          settingCubit,
          newsCubit,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: Column(
            children: [
              Container(
                /// (Container content) Programming for the top tabBar
                height: 45.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: settingCubit.gradientColorStart,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0, 1],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: const Color(0xfffdf0d5),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: categoriesList
                      .map((category) => Tab(
                            text: category,
                          ))
                      .toList(),
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: newsScreens.map((screen) => screen).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    bool isDark,
    SettingCubit settingCubit,
    NewsCubit newsCubit,
  ) {
    TextStyle? displaySmall = Theme.of(context).textTheme.displaySmall;

    return AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'title_appBar'.translate(context),
          ),
          const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.h,
                  color: Colors.white,
                ),
                onPressed: () => navigatorTo(context, const SearchScreen()),
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: PopupMenuButton(
          icon: Icon(
            Icons.menu,
            size: 22.h,
            color: Colors.white,
          ),
          //iconSize: 20.h,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'egypt'.translate(context),
              child: Text('egypt'.translate(context)),
            ),
            PopupMenuItem(
              value: 'united_states'.translate(context),
              child: Text('united_states'.translate(context)),
            ),
            PopupMenuItem(
              value: 'germany'.translate(context),
              child: Text('germany'.translate(context)),
            ),
            PopupMenuItem(
              value: 'france'.translate(context),
              child: Text('france'.translate(context)),
            ),
            PopupMenuItem(
              value: 'france'.translate(context),
              child: Row(
                children: [
                  Text(
                    'gridView'.translate(context),
                    style: displaySmall,
                  ),
                  Switch(
                      activeTrackColor: const Color(0xff003566),
                      activeColor: Colors.amber,
                      inactiveTrackColor: Colors.grey,
                      value: settingCubit.listView,
                      onChanged: (newView) {
                        settingCubit.onChangeView(newView);

                        /// The next line is a dummy way to do a page reload
                        newsCubit.onChangeCountry(country);
                        Navigator.of(context).pop();
                      }),
                  Text(
                    'listView'.translate(context),
                    style: displaySmall,
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'egypt'.translate(context)) {
              newsCubit.onChangeCountry('eg');
            } else if (value == 'united_states'.translate(context)) {
              newsCubit.onChangeCountry('us');
            } else if (value == 'germany'.translate(context)) {
              newsCubit.onChangeCountry('de');
            } else if (value == 'france'.translate(context)) {
              newsCubit.onChangeCountry('fr');
            }
          },
        ),
      ),
      flexibleSpace: Container(
        /// (flexibleSpace )This is to create the linear gradient
        /// for the appBar color
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: settingCubit.gradientColorStart,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1],
          ),
        ),
      ),
      actions: [
        Container(
          color: !isDark ? Colors.white : null,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 10.w,
          ),
          child: IconButton(
            onPressed: () {
              settingCubit.onChangeTheme();
            },
            icon: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : Colors.black,
              size: 30.h,
            ),
          ),
        ),
      ],
    );
  }
}
