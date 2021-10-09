import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/CounterCubit.dart';
import 'package:newsapp/Cubit/CounterState.dart';
import 'package:newsapp/Screens/Search.dart';
import 'package:newsapp/network/local/CacheHelper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'MyBlocObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool themeApp;

  MyApp(this.themeApp);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterCubit()
          ..getDateBusiness()
          ..getDateSports()
          ..getDateScience()
          ..changeTheme(themeApp: themeApp),
        child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, index) {},
          builder: (context, index) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Counter(themeApp),
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BalsamiqSans",
                    fontSize: 18,
                  ),
                  body2: TextStyle(
                    fontFamily: "BalsamiqSans",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
              ),
              darkTheme: ThemeData(
                textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BalsamiqSans",
                    fontSize: 18,
                  ),
                  body2: TextStyle(
                    fontFamily: "BalsamiqSans",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                scaffoldBackgroundColor: Color(0xFF242526),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: Color(0xFF242526),
                  elevation: 0,
                  backwardsCompatibility: false,
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xFF242526),
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
              ),
              themeMode: CounterCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ));
  }
}

class Counter extends StatelessWidget {
  final bool themeApp;

  Counter(this.themeApp);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              " News App",
              style: Theme.of(context).textTheme.body2,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Search();
                  }));
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  CounterCubit.get(context).changeTheme();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          bottomNavigationBar: SalomonBottomBar(
            margin: EdgeInsets.all(10),
            currentIndex: CounterCubit.get(context).count,
            selectedItemColor:
                CounterCubit.get(context).isDark ? Colors.white : Colors.black,
            unselectedItemColor:
                CounterCubit.get(context).isDark ? Colors.white : Colors.black,
            onTap: (index) {
              CounterCubit.get(context).increase(index);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.business_sharp,
                  size: 30,
                ),
                title: Text("Business"),
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.sports_volleyball,
                  size: 30,
                ),
                title: Text("Sports"),
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.science_outlined,
                  size: 30,
                ),
                title: Text("Science"),
              ),
            ],
          ),
          body: state is LoadingDate
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CounterCubit.get(context)
                  .screens[CounterCubit.get(context).count],
        );
      },
    );
  }
}
