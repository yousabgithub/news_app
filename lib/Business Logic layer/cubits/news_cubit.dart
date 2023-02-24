import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../Data Layer/web_services.dart';
import '../states/news_states.dart';

import '../../presentation layer/constants/constants.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitNewsStates());

  static NewsCubit getObject(context) => BlocProvider.of(context);

  /// This special programming that reflects the change of the city
  /// taking into account the changing trends and language..
  void onChangeCountry(String newCountry) async {
    country = newCountry;

    fetchGeneralNews();
    fetchBusinessNews();
    fetchScienceNews();
    fetchSportsNews();
    fetchHealthNews();
    if (country == 'eg') {
      currentLocale = const Locale("ar");
      defaultDirection = TextDirection.rtl;
    } else if (country == 'us') {
      currentLocale = const Locale("en", "US");
      defaultDirection = TextDirection.ltr;
    } else if (country == 'de') {
      currentLocale = const Locale("de");
      defaultDirection = TextDirection.ltr;
    } else {
      currentLocale = const Locale("fr");
      defaultDirection = TextDirection.ltr;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('country', country);

    emit(OnChangeCountryState());
  }

  getCountryFromPref() async {
    var pref = await SharedPreferences.getInstance();
    country = pref.getString('country') ?? 'eg';
    if (country == "eg") {
      currentLocale = const Locale("ar");
      defaultDirection = TextDirection.rtl;
    } else if (country == "us") {
      currentLocale = const Locale("en", "US");
      defaultDirection = TextDirection.ltr;
    } else if (country == 'de') {
      currentLocale = const Locale("de");
      defaultDirection = TextDirection.ltr;
    } else {
      currentLocale = const Locale("fr");
      defaultDirection = TextDirection.ltr;
    }
    emit(GetCountryPrefState());
  }

  List generalNews = [];

  void fetchGeneralNews() {
    emit(NewsDataLoadingState());
    DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'country': country,
      'category': 'general',
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    }).then((value) {
      generalNews = value?.data['articles'];
      emit(NewsDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('fetchGeneralNews==${error.toString()}');
      }
      emit(NewsDataErrorState());
    });
  }

  List businessNews = [];

  void fetchBusinessNews() {
    emit(NewsDataLoadingState());

    DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'country': country,
      'category': 'business',
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    }).then((value) {
      businessNews = value?.data['articles'];
      emit(NewsDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('fetchBusinessNews==${error.toString()}');
      }

      emit(NewsDataErrorState());
    });
  }

  List scienceNews = [];

  void fetchScienceNews() {
    emit(NewsDataLoadingState());

    DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'country': country,
      'category': 'science',
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    }).then((value) {
      scienceNews = value?.data['articles'];

      emit(NewsDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('fetchScienceNews==${error.toString()}');
      }

      emit(NewsDataErrorState());
    });
  }

  List sportsNews = [];

  void fetchSportsNews() {
    emit(NewsDataLoadingState());

    DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'country': country,
      'category': 'sports',
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    }).then((value) {
      sportsNews = value?.data['articles'];

      emit(NewsDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('fetchSportsNews${error.toString()}');
      }

      emit(NewsDataErrorState());
    });
  }

  List healthNews = [];

  void fetchHealthNews() {
    emit(NewsDataLoadingState());

    DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'country': country,
      'category': 'health',
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    }).then((value) {
      healthNews = value?.data['articles'];

      emit(NewsDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('fetchHealthNews${error.toString()}');
      }

      emit(NewsDataErrorState());
    });
  }

  List searchNews = [];

  Future<void> fetchSearchNews(String textSearch) async {
    searchNews.clear();
    emit(SearchNewsLoadingState());
    Response? responsive =
        await DioHelper.getNetworkData(url: 'v2/top-headlines', query: {
      'q': textSearch,
      'apiKey': 'aa4c13cba49e4a8fb5082615219bab65',
    });
    if (responsive?.statusCode == 200) {
      searchNews = responsive!.data['articles'];
      emit(SearchNewsSuccessState());
    } else {
      if (kDebugMode) {
        print('fetchSearchNewsErrorFunction');
      }
      emit(SearchNewsErrorState());
    }
  }

  void clearSearchData() {
    searchNews.clear();
    emit(ClearSearchDataSuccessState());
  }
}
