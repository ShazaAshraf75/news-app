// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "تجاريه"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "رياضيه"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "علميه"),
  ];
  List<Widget> screens = [
    BussinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;

    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country": "eg",
        "category": "business",
        "apiKey": "0b2875b2658e4ed081a27ca12367bd60"
      },
    ).then((value) {
      business = value.data["articles"];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    if (sports.isEmpty) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "0b2875b2658e4ed081a27ca12367bd60"
        },
      ).then((value) {
        sports = value.data["articles"];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    if (science.isEmpty) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "0b2875b2658e4ed081a27ca12367bd60"
        },
      ).then((value) {
        science = value.data["articles"];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetBusinessLoadingState());

    search = [];

    DioHelper.getData(
      url: "v2/everything",
      // ignore: unnecessary_string_interpolations
      query: {"q": "$value", "apiKey": "0b2875b2658e4ed081a27ca12367bd60"},
    ).then((value) {
      search = value.data["articles"];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
