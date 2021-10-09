import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/CounterState.dart';
import 'package:newsapp/Screens/Screen1.dart';
import 'package:newsapp/Screens/Screen2.dart';
import 'package:newsapp/Screens/Screen3.dart';
import 'package:newsapp/network/local/CacheHelper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(InitialSatate());
  static CounterCubit get(context) => BlocProvider.of(context);

  List screens = [
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  int count = 0;
  void increase(int index) {
    count = index;
    emit(ChangeButton());
  }

  List<dynamic> business = [];
  void getDateBusiness() {
    emit(LoadingDate());
    DioHelper.getDate(
      url: 'v2/top-headlines',
      query: {
        'country': "us",
        'category': "business",
        'apiKey': "1bbab93cee8d475aaf0850e340510366",
      },
    ).then((value) {
      emit(SuccessfulDate());
      business = value.data["articles"];
      print(business[0]['author']);
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDate());
    });
  }

  List<dynamic> sports = [];
  void getDateSports() {
    emit(LoadingDate());
    DioHelper.getDate(
      url: 'v2/top-headlines',
      query: {
        'country': "us",
        'category': "sports",
        'apiKey': "1bbab93cee8d475aaf0850e340510366",
      },
    ).then((value) {
      emit(SuccessfulDate());
      sports = value.data["articles"];
      print(business[0]['author']);
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDate());
    });
  }

  List<dynamic> science = [];
  void getDateScience() {
    emit(LoadingDate());
    DioHelper.getDate(
      url: 'v2/top-headlines',
      query: {
        'country': "us",
        'category': "science",
        'apiKey': "1bbab93cee8d475aaf0850e340510366",
      },
    ).then((value) {
      emit(SuccessfulDate());
      science = value.data["articles"];
      print(business[0]['author']);
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDate());
    });
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    search = [];
    emit(LoadingGetSearch());
    DioHelper.getDate(
      url: 'v2/everything',
      query: {
        'q': "$value",
        'apiKey': "1bbab93cee8d475aaf0850e340510366",
      },
    ).then((value) {
      emit(SuccessfulGetSearch());
      search = value.data["articles"];
      print(search[0]['author']);
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetSearch());
    });
  }

  bool isDark = false;

  void changeTheme({bool? themeApp}) {
    if (themeApp != null) {
      isDark = themeApp;
      emit(ChangeThemeApp());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(ChangeThemeApp());
      });
      emit(ChangeThemeApp());
    }
  }
}
