import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import '../../Business Logic layer/states/news_states.dart';
import '../widgets/custom_grid_view.dart';

import '../widgets/news_item.dart';

class SportsNewsScreen extends StatelessWidget {
  const SportsNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List sportsNews = NewsCubit.getObject(context).sportsNews;
        bool listView = SettingCubit.getObject(context).listView;
        if (listView) {
          return ListView.builder(
            itemCount: sportsNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: sportsNews[index],
            ),
          );
        } else {
          return CustomGridView(
            itemCount: sportsNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: sportsNews[index],
            ),
          );
        }
      },
    );
  }
}
