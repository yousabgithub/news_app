import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business Logic layer/cubits/news_cubit.dart';
import '../../Business Logic layer/cubits/setting_cubit.dart';
import '../../Business Logic layer/states/news_states.dart';
import '../widgets/custom_grid_view.dart';

import '../widgets/news_item.dart';

class BusinessNewsScreen extends StatelessWidget {
  const BusinessNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List businessNews = NewsCubit.getObject(context).businessNews;
          bool listView = SettingCubit.getObject(context).listView;
          if (listView) {
            return ListView.builder(
              itemCount: businessNews.length,
              itemBuilder: (ctx, index) => NewsItem(
                index: index,
                newsDetails: businessNews[index],
              ),
            );
          } else {
            return CustomGridView(
              itemCount: businessNews.length,
              itemBuilder: (ctx, index) => NewsItem(
                index: index,
                newsDetails: businessNews[index],
              ),
            );
          }
        });
  }
}
