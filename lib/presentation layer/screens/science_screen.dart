import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import '../../Business Logic layer/states/news_states.dart';
import '../widgets/custom_grid_view.dart';

import '../widgets/news_item.dart';

class ScienceNewsScreen extends StatelessWidget {
  const ScienceNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List scienceNews = NewsCubit.getObject(context).scienceNews;
        bool listView = SettingCubit.getObject(context).listView;

        if (listView) {
          return ListView.builder(
            itemCount: scienceNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: scienceNews[index],
            ),
          );
        } else {
          return CustomGridView(
            itemCount: scienceNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: scienceNews[index],
            ),
          );
        }
      },
    );
  }
}
