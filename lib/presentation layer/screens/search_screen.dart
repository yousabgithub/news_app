import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import '../../Business Logic layer/states/news_states.dart';
import '../widgets/web_view_screen.dart';

import '../constants/constants.dart';
import '../widgets/custom_field.dart';
import '../widgets/custom_grid_view.dart';
import '../widgets/news_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey _key = GlobalKey<FormState>();

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.getObject(context);
          SettingCubit settingCubit = SettingCubit.getObject(context);
          return Directionality(
            textDirection: defaultDirection,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: settingCubit.gradientColorStart,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0, 1],
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      CustomField(
                        onPressedSuffixIcon: () {
                          cubit.clearSearchData();
                          controller.text = '';
                        },
                        onFieldSubmitted: (textSearch) {
                          cubit.fetchSearchNews(textSearch);
                        },
                        controller: controller,
                      ),
                      SizedBox(height: 20.h),
                      if (state is SearchNewsLoadingState)
                        const LinearProgressIndicator(),
                      if (state is SearchNewsSuccessState)

                        /// This condition is for display style programming
                        settingCubit.listView
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: cubit.searchNews.length,
                                  itemBuilder: (ctx, index) {
                                    return InkWell(
                                      onTap: () {
                                        navigatorTo(
                                          context,
                                          WebViewScreen(
                                            cubit.searchNews[index]['url'],
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: NewsItem(
                                        index: index,
                                        newsDetails: cubit.searchNews[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: CustomGridView(
                                  itemCount: cubit.searchNews.length,
                                  itemBuilder: (ctx, index) => NewsItem(
                                    index: index,
                                    newsDetails: cubit.searchNews[index],
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
