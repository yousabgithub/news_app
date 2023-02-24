import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import '../../Business Logic layer/states/news_states.dart';
import '../widgets/custom_grid_view.dart';

import '../widgets/news_item.dart';

class GeneralNewsScreen extends StatelessWidget {
  const GeneralNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List generalNews = NewsCubit.getObject(context).generalNews;
        bool listView = SettingCubit.getObject(context).listView;

        /// This condition is for display style programming
        if (listView) {
          return ListView.builder(
            itemCount: generalNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: generalNews[index],
            ),
          );
        } else {
          return CustomGridView(
            itemCount: generalNews.length,
            itemBuilder: (ctx, index) => NewsItem(
              index: index,
              newsDetails: generalNews[index],
            ),
          );
        }
      },
    );
  }
}
