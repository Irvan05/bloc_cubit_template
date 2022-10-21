import 'package:bloc_cubit_template/basic_builder/basic_builder_generated.dart';
import 'package:bloc_cubit_template/basic_builder/basic_builder_page.dart';
import 'package:bloc_cubit_template/basic_builder/counter_bloc.dart';
import 'package:bloc_cubit_template/basic_builder/other_page_generated.dart';
import 'package:bloc_cubit_template/basic_builder/theme_bloc.dart';
import 'package:bloc_cubit_template/basic_builder/user_cubit.dart';
import 'package:bloc_cubit_template/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRouter {
  Counter myCounter = Counter(init: 0);
  ThemeBloc myTheme = ThemeBloc();
  UserCubit myUser = UserCubit();

  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (context) => const HomePage());
      //NORMAL PAGES
      case HomePage.routeName:
        return CupertinoPageRoute(builder: (context) => const HomePage());
      case BasicBuilderPage.routeName:
        return CupertinoPageRoute(builder: (context) => BasicBuilderPage());
      // GENERATED PAGES
      // BLOC PROVIDER AKAN DISPOSE BLOCNYA PAS HALAMAN DITUTUP,
      // JADI HARUS INIT BLOC SETIAP HALAMAN MAU DIPANGGIL
      case BasicBuilderGenerated.routeName:
        initBuillderGeneratedBloc();
        return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => myCounter),
                  BlocProvider(create: (context) => myTheme),
                  BlocProvider(create: (context) => myUser)
                ], child: BasicBuilderGenerated()));
      // return CupertinoPageRoute(
      //     builder: (context) => BlocProvider.value(
      //         value: myCounter, child: BasicBuilderGenerated()));
      case OtherPageGenerated.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider.value(
                value: myCounter, child: OtherPageGenerated()));
      // DEFAULT SHOULD BE PAGE NOT FOUND
      default:
        return CupertinoPageRoute(builder: (context) => const HomePage());
    }
  }

  void initBuillderGeneratedBloc() {
    if (myCounter.isClosed) {
      myCounter = Counter(init: 1);
    }
    if (myTheme.isClosed) {
      myTheme = ThemeBloc();
    }
    if (myUser.isClosed) {
      myUser = UserCubit();
    }
  }
}
